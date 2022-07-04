import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:modbus/modbus.dart' as modbus;
import 'package:modbus/modbus.dart';

import '../../model/DataObserver.dart';
import 'ModbusObserver.dart';

/// Class for holding information on each modbus device
class MBServer{
  // Modbus parameters
  final String ipAddress;
  final int port;
  final ModbusMode mode;
  // Modbus server
  late final serverID;

  MBServer(this.ipAddress, {this.port=502, this.mode=ModbusMode.rtu, this.serverID=0});

  void updateServerID(int id){
    serverID = serverID;
  }
}

/// Class for handling Modbus connections and devices
class MBHandler with ChangeNotifier{
  // List of Modbus Connections
  final List<_MBConnection> connections = [];
  final Map<String, _MBConnection> connectionMap = {};
  // Poll Parameter
  late int pollRate;

  // Initialize TCP Client Connection
  void createModbusConnection({required MBServer server, required bool readOnly, int pollRate=1000,
    required discreteInputReadSize, required discreteInputStartAddress,
    required inputRegisterReadSize, required inputRegisterStartAddress,
    required coilReadSize, required coilStartAddress,
    required holdingRegisterReadSize, required holdingRegisterStartAddress}){

    ModbusClient client = modbus.createTcpClient(
      server.ipAddress,
      port: server.port,
      mode: server.mode,
      unitId: server.serverID,
    );

    _MBConnection connection = _MBConnection(
      server: server,
      client: client,
      readOnly: readOnly,
      discreteInputStartAddress: discreteInputStartAddress,
      discreteInputReadSize: discreteInputReadSize,
      inputRegisterStartAddress: inputRegisterStartAddress,
      inputRegisterReadSize: inputRegisterReadSize,
      coilStartAddress: coilStartAddress,
      coilReadSize: coilReadSize,
      holdingRegisterStartAddress: holdingRegisterStartAddress,
      holdingRegisterReadSize: holdingRegisterReadSize,
    );
    connections.add(connection);
    connectionMap[server.ipAddress] = connection;
    this.pollRate = pollRate;
  }

  // TODO: TEST ONLY
  void addObserver(String ip, ModbusObserver observer){
    connectionMap[ip]!.addObserver(observer); //TODO : Do exception handling for non-existent connections
  }

  void startPoll(){
    Timer.periodic(Duration(milliseconds: pollRate), (timer) {
      readAll();
    });
  }

  void stopPoll(){

  }

  // Attempt Connections
  void connectAll() async{
    for(_MBConnection c in connections){
      c.connect();
    }
  }

  // Perform Read on all connections
  void readAll() {
    for(_MBConnection c in connections){
      c.read();
    }
  }

  // Get Data
  List<bool> getData(String ipAddress){
    for(_MBConnection c in connections){
      if(c.server.ipAddress == ipAddress){
        return c.discreteInputs;
      }
    }
    return []; // TODO: Handle Exceptions
  }
  // Write Data
  void writeData(String ipAddress, int address, bool state) async {
    connectionMap[ipAddress]!.write(address, state);
  }

  // Send Commands - These are typically one-shot type and should reset after 1x scan time
  void sendCommand(String ipAddress, int address) async {
    connectionMap[ipAddress]!.write(address, true);
    // Wait for a full scan rate
    Timer(Duration(milliseconds: pollRate), (){
      connectionMap[ipAddress]!.write(address, false);
    });
  }

}

/// Class for each Modbus to Client Connection
/// This class holds all read and write parameters, and information on
/// modbus devices that are associated with this connection
class _MBConnection{
  // Connection Status
  late bool isConnected;
  // Modbus Read Parameters
  late List<bool> discreteInputs;
  int discreteInputReadSize;
  int discreteInputStartAddress;
  late List<int> inputRegisters;
  int inputRegisterReadSize;
  int inputRegisterStartAddress;
  // Modbus Write Parameters
  late List<bool> coils;
  int coilReadSize;
  int coilStartAddress;
  late List<int> holdingRegisters;
  int holdingRegisterReadSize;
  int holdingRegisterStartAddress;
  // Read-Write Access
  final bool readOnly;
  // Modbus Server and Client
  final MBServer server;
  final ModbusClient client;
  // Data Observers
  final List<ModbusObserver> observers = [];

  // Constructor
  _MBConnection({required this.server, required this.client, required this.readOnly,
    required this.discreteInputReadSize, required this.discreteInputStartAddress,
    required this.inputRegisterReadSize, required this.inputRegisterStartAddress,
    required this.coilReadSize, required this.coilStartAddress,
    required this.holdingRegisterReadSize, required this.holdingRegisterStartAddress}) {

    // Force Write access to nothing if read only mode is passed
    if(readOnly == true) {
      coilReadSize = 0;
      coilStartAddress = 0;
      holdingRegisterReadSize = 0;
      holdingRegisterStartAddress = 0;
    }

    // Initialize output and input registers - 16 bit registers
    coils = List.filled(coilReadSize, false);
    discreteInputs = List.filled(discreteInputReadSize, false);

    // Connection Status
    isConnected = false;
  }

  // Complete Connection
  Future<void> connect() async{
    try{
      await client.connect();
      isConnected = true;
    }
    catch(e){
      print("Connection Exception: $e");
      isConnected = false;
    }
  }

  // Read Input Registers
  void read() async {
//    await _writeCoils(); // TODO
//    await _writeHoldingRegisters(); // TODO
    discreteInputs = await _readDiscreteInputs();
//    inputRegisters = await _readInputRegisters(); // TODO

//    notifyDataObservers(coils); // TODO
    notifyDataObservers(discreteInputs);
//    notifyDataObservers(inputRegisters); // TODO
//    notifyDataObservers(holdingRegisters); // TODO
  }

  // Write Output Registers
  void write(int address, bool state) async {
    // TODO
    await client.writeSingleCoil(address, state);
  }

  /// Read Functions
  Future<List<int>> _readInputRegisters() async {
    try {
      Uint16List registers = await client.readInputRegisters(
      inputRegisterStartAddress, inputRegisterReadSize);
      return registers.toList();
    }
    // Exception thrown when read size is over 2000
    on modbus.ModbusAmountException catch(e){
      print("Debug: ModbusAmountException - ${e.toString()}");
      return List.filled(discreteInputReadSize, 0);
    }
    // Exception thrown when read address doesn't meet the following criteria:
    //  - Address range not setup as discrete inputs on modbus device
    //  - Address range isn't in a valid format
    on modbus.ModbusIllegalAddressException catch(e){
      print("Debug: ModbusIllegalAddressException - ${e.toString()}");
      return List.filled(discreteInputReadSize, 0);
    }
    // Any other exceptions not expected nor captured will throw this error
    // This is added for future debugging
    catch(e){
      print("Debug: Unexpected Exception ${e.toString()}");
      print("Debug: Please report this exception and handle accordingly.");
      return List.filled(discreteInputReadSize, 0);
    }
  }

  Future<List<bool>> _readDiscreteInputs() async {
    try {
      List<bool?> bits = await client.readDiscreteInputs(
          discreteInputStartAddress, discreteInputReadSize);
      List<bool> res = List.filled(discreteInputReadSize, false);

      for (int i = 0; i < bits.length - 1; i++) {
        res[i] = bits[i]!;
      }

      return res;
    }
    // Exception thrown when read size is over 2000
    on modbus.ModbusAmountException catch(e){
      print("Debug: ModbusAmountException - ${e.toString()}");
      return List.filled(discreteInputReadSize, false);
    }
    // Exception thrown when read address doesn't meet the following criteria:
    //  - Address range not setup as discrete inputs on modbus device
    //  - Address range isn't in a valid format
    on modbus.ModbusIllegalAddressException catch(e){
      print("Debug: ModbusIllegalAddressException - ${e.toString()}");
      return List.filled(discreteInputReadSize, false);
    }
    // Any other exceptions not expected nor captured will throw this error
    // This is added for future debugging
    catch(e){
      print("Debug: Unexpected Exception ${e.toString()}");
      print("Debug: Please report this exception and handle accordingly.");
      return List.filled(discreteInputReadSize, false);
    }
  }

  /// WRITE TEST
  Future<void> _write(int address, bool state) async {
    await client.writeSingleCoil(address, state);
  }

  /// Write Functions
  Future<void> _writeCoils() async {
    await client.writeMultipleCoils(coilStartAddress, coils);
  }

  Future<void> _writeHoldingRegisters() async{
    await client.writeMultipleRegisters(holdingRegisterStartAddress, Uint16List.fromList(holdingRegisters));
  }

  /// Conversion Function Blocks
  // Convert word to bits
  List<int> _wordToInts({required int word, bool reversed=false}){
    List<int> bits = List.filled(16, 0);       // Allocation for 16 bit word
    List<int> revBits = List.filled(16, 0);  // Reversed version of bit sequence
    int num = word;       // Integer for modulo looping
    int i = 0;
    // For each iteration, 'num' modulo zero equates to bit assignment
    while(num > 0) {
      revBits[i] = num % 2;
      num = (num~/2).toInt();     // Conversion back to integer after division

      i += 1;
    }
    // Reverse the order of the bit sequence - dependent on server side implementation
    if(reversed == true) {
      bits = new List.from(revBits.reversed);
    }
    else {
      bits = revBits;
    }
    return bits;
  }

  // Convert word to bits
  List<bool> _wordToBits({required int word, bool reversed=false}){
    List<int> bits = List.filled(16, 0);       // Allocation for 16 bit word
    List<int> revBits = List.filled(16, 0);  // Reversed version of bit sequence
    List<bool> boolBits = [];

    int num = word;       // Integer for modulo looping
    int i = 0;
    // For each iteration, 'num' modulo zero equates to bit assignment
    while(num > 0) {
      revBits[i] = num % 2;
      num = (num~/2).toInt();     // Conversion back to integer after division

      i += 1;
    }
    // Reverse the order of the bit sequence - dependent on server side implementation
    if(reversed == true) {
      bits = new List.from(revBits.reversed);
    }
    else {
      bits = revBits;
    }
    // Convert to boolean
    for(i=0; i<bits.length; i++){
      if(bits[i] == 0){
        boolBits[i] = false;
      }
      else{
        boolBits[i] = true;
      }
      i++;
    }
    return boolBits;
  }

  void addObserver(ModbusObserver observer){
    observers.add(observer);
  }

  void notifyDataObservers(List<bool> data){
    for(ModbusObserver observer in observers){
      observer.update(data);
    }
  }
}

