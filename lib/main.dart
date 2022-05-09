import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windows/model/alert/AlertDataHandler.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/view/screen/MainScreen.dart';
import 'package:provider/provider.dart';

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

    // Add room data handler to master
    master.addDataHandler(id, dataHandler);
  }
//
//  // Initialize Handlers
//  ActionDataHandler actionDataHandler = ActionDataHandler();
//  AlertDataHandler alertDataHandler = AlertDataHandler();
//  EquipmentDataHandler equipmentDataHandler = EquipmentDataHandler();
//  PuzzleDataHandler puzzleDataHandler = PuzzleDataHandler();
//  RoomDataHandler roomDataHandler = RoomDataHandler();
//
//  // Extract Room Information
//  Map<String, String> vaultRoomInfo = await ExtractRoomInfo("tvrm01");
//  Map<String, String> flightRoomInfo = await ExtractRoomInfo("flrm01");
//  Map<String, String> magicianRoomInfo = await ExtractRoomInfo("mcrm01");
//  Map<String, String> elevatorRoomInfo = await ExtractRoomInfo("term01");
//  // Extract Equipment Data List
//  List<List<String>> flightEquipmentDataList = await ExtractEquipmentDataList("flrm01");
//  // Extract Puzzle Data List
//  List<List<String>> flightPuzzleDataList = await ExtractPuzzleDataList("flrm01");
//
//  // Parse and Add Room Information
//  roomDataHandler.addRoom(vaultRoomInfo);
//  roomDataHandler.addRoom(flightRoomInfo);
//  roomDataHandler.addRoom(magicianRoomInfo);
//  roomDataHandler.addRoom(elevatorRoomInfo);
//
//  // Parse and Add Equipment Data List
//  equipmentDataHandler.addEquipment("flrm01", flightEquipmentDataList);
//
//  // Parse and Add PuzzleData List
//  puzzleDataHandler.addPuzzle("flrm01", flightPuzzleDataList);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: master,
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

