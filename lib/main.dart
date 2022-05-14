import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windows/model/alert/AlertDataHandler.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/view/screen/MainScreen.dart';
import 'package:provider/provider.dart';

import 'controller/ModbusHandler.dart';
import 'controller/io.dart';
import 'model/DataHandler.dart';
import 'model/DataMaster.dart';
import 'model/action/ActionDataHandler.dart';
import 'model/puzzle/PuzzleDataHandler.dart';
import 'model/room/RoomDataHandler.dart';

void main() async {
  List<String> roomIDList = await getDirectoryNames("resources\\");
  // Initialize Data Master
  DataMaster master = DataMaster();
  // Initialize Modbus Handler
  MBHandler modbusHandler = new MBHandler();

  for(String id in roomIDList){
    // Initialize Handlers
    ActionDataHandler actionDataHandler = ActionDataHandler();
    AlertDataHandler alertDataHandler = AlertDataHandler();
    EquipmentDataHandler equipmentDataHandler = EquipmentDataHandler();
    PuzzleDataHandler puzzleDataHandler = PuzzleDataHandler();
    RoomDataHandler roomDataHandler = RoomDataHandler();

    // Extract Room Information
    Map<String, String> roomInfo = await ExtractRoomInfo(id);
    // Extract Equipment Data List
    List<List<String>> equipmentDataList = await ExtractEquipmentDataList(id);
    // Extract Puzzle Data List
    List<List<String>> puzzleDataList = await ExtractPuzzleDataList(id);

    // Parse and Add Room Information
    roomDataHandler.addRoom(roomInfo);
    // Parse and Add Equipment Data List
    equipmentDataHandler.addEquipment(equipmentDataList);
    // Parse and Add Puzzle Data List
    puzzleDataHandler.addPuzzle(puzzleDataList);

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
        server: MBServer(ip),
        readOnly: true,
        readSize: 20,
        readStartAddress: 0
    );
    // Add observer to modbus handler
    modbusHandler.addObserver(ip, dataHandler);

    // Add room data handler to master
    master.addDataHandler(id, dataHandler);
  }

  // // Get all IP Addresses
  // List<String> ipAddresses = [];
  // for(DataHandler dataHandler in master.getDataHandlerList()){
  //   ipAddresses.add(dataHandler.roomDataHandler.getRoom().ip);
  // }
  // print(ipAddresses);


  // modbusHandler.startLoop();

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

