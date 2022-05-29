import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windows/controller/room/flight_room/FlightRoomAlertDataHandler.dart';
import 'package:flutter_windows/model/alert/AlertData.dart';
import 'package:flutter_windows/model/alert/AlertDataHandler.dart';
import 'package:flutter_windows/model/equipment/EquipmentData.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/model/puzzle/PuzzleData.dart';
import 'controller/room/flight_room/FlightRoomEquipmentDataHandler.dart';
import 'controller/room/flight_room/FlightRoomPuzzleDataHandler.dart';
import 'package:flutter_windows/view/screen/MainScreen.dart';
import 'package:provider/provider.dart';

import 'controller/data/ModbusHandler.dart';
import 'controller/io.dart';
import 'model/DataHandler.dart';
import 'model/DataMaster.dart';
import 'model/action/ActionDataHandler.dart';
import 'model/puzzle/PuzzleDataHandler.dart';
import 'model/room/RoomDataHandler.dart';

void main() async {
  List<String> roomIDListActivated = ['flrm01'];
  List<String> roomIDList = await getDirectoryNames("resources\\");
  // Initialize Data Master
  DataMaster master = DataMaster();
  // Initialize Modbus Handler
  MBHandler modbusHandler = new MBHandler();

  for(String id in roomIDList){
    if(roomIDListActivated.contains(id) == false){
      break;
    }
    // Initialize Handlers
    ActionDataHandler actionDataHandler = ActionDataHandler();
    FlightRoomAlertDataHandler alertDataHandler = FlightRoomAlertDataHandler();
    FlightRoomEquipmentDataHandler equipmentDataHandler = FlightRoomEquipmentDataHandler();
    FlightRoomPuzzleDataHandler puzzleDataHandler = FlightRoomPuzzleDataHandler();
    RoomDataHandler roomDataHandler = RoomDataHandler();

    // Extract Room Information
    Map<String, String> roomInfo = await ExtractRoomInfo(id);
    // Extract Equipment Data List
    List<List<String>> equipmentDataList = await ExtractEquipmentDataList(id);
    // Extract Puzzle Data List
    List<List<String>> puzzleDataList = await ExtractPuzzleDataList(id);
    // Extract Alert Data List
    List<List<String>> alertDataList = await ExtractAlertDataList(id);

    // Parse and Add Room Information
    roomDataHandler.addRoom(roomInfo);
    // Parse and Add Equipment Data List
    equipmentDataHandler.addEquipment(equipmentDataList);
    EquipmentDataSource equipmentDataSource = EquipmentDataSource(equipmentStates: equipmentDataHandler.equipmentDataList);
    equipmentDataHandler.equipmentDataSource = equipmentDataSource;
    // Parse and Add Puzzle Data List
    puzzleDataHandler.addPuzzle(puzzleDataList);
    PuzzleDataSource puzzleDataSource = PuzzleDataSource(puzzleStates: puzzleDataHandler.puzzleDataList);
    puzzleDataHandler.puzzleDataSource = puzzleDataSource;
    // Parse and Add Alert Data List
    alertDataHandler.addAlertReference(alertDataList);
    AlertDataSource alertDataSource = AlertDataSource(alerts: alertDataHandler.activeAlertList);
    alertDataHandler.alertDataSource = alertDataSource;


    // Initialize Data Handler
    DataHandler dataHandler = DataHandler(
      roomID: id,
      actionDataHandler: actionDataHandler,
      alertDataHandler: alertDataHandler,
      equipmentDataHandler: equipmentDataHandler,
      puzzleDataHandler: puzzleDataHandler,
      roomDataHandler: roomDataHandler,
    );

    // Get IP address of this connection server
    String ip = dataHandler.roomDataHandler.getRoom().ip;
    // Create modbus connection
    modbusHandler.createModbusConnection(
      server: new MBServer(ip),
      readOnly: true,
      coilReadSize: 1000, coilStartAddress: 0,
      discreteInputReadSize: 1000, discreteInputStartAddress: 0,
      holdingRegisterReadSize: 1, holdingRegisterStartAddress: 0,
      inputRegisterStartAddress: 1, inputRegisterReadSize: 0,
      pollRate: 1000
    );
    // Attempt connection establishment
    await modbusHandler.connectionMap[ip]!.connect();

    int connectCount = 0;
    // Retry connections - 2 second intervals, up to 5 retries
    while(modbusHandler.connectionMap[ip]!.isConnected == false && connectCount < 5){
      // Attempt connection establishment
      modbusHandler.connectionMap[ip]!.connect();
      connectCount++;
      print("Debug: Connection establishment unsuccessful. Retrying... $connectCount/5");
    }

    if(modbusHandler.connectionMap[ip]!.isConnected == true) {
      print("Debug: Connection Successful");
      // Add observer to modbus handler
      modbusHandler.addObserver(ip, dataHandler);

      // Add room data handler to master
      master.addDataHandler(id, dataHandler);
    }
    else{
      print("Debug: Connection Exception - Cannot establish connection with IP address $ip");
    }
  }
  modbusHandler.startPoll();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: master,
        ),
        ChangeNotifierProvider.value(
          value: modbusHandler,
        ),
      ],
      child: WinApp(),
    )
  );
}

class WinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.blue,
        inactiveColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        navigationPaneTheme: NavigationPaneThemeData(
          animationDuration: const Duration(milliseconds: 100),
          highlightColor: Colors.orange.resolveFromReverseBrightness(
            Brightness.light,
            level: Brightness.light.isDark ? 2 : 0,
          ),
          selectedIconColor: ButtonState.all(
            Colors.blue,
          ),
          unselectedIconColor: ButtonState.all(
            Colors.black,
          ),
          iconPadding: const EdgeInsets.all(8),
          selectedTextStyle: ButtonState.all(
            const TextStyle(
              fontSize: 20,
              color: Colors.black
            ),
          ),
          unselectedTextStyle: ButtonState.all(
            const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          itemHeaderTextStyle: const TextStyle(
            fontSize: 30,
            color: Colors.black,
          )
        ),
      ),
      home: const MainScreen(),
    );
  }
}

