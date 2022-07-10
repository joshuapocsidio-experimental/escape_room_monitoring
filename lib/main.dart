import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windows/controller/room/flight_room/handler/FlightStageDataHandler.dart';
import 'package:flutter_windows/model/DataController.dart';
import 'package:flutter_windows/model/DataControllerManager.dart';
import 'controller/room/flight_room/handler/FlightAlertDataHandler.dart';
import 'controller/room/flight_room/controller/FlightGameController.dart';
import 'controller/room/flight_room/handler/FlightGameDataHandler.dart';
import 'package:flutter_windows/model/alert/AlertData.dart';
import 'package:flutter_windows/model/equipment/EquipmentData.dart';
import 'package:flutter_windows/model/game/GameControlData.dart';
import 'package:flutter_windows/model/game/GameDataController.dart';
import 'package:flutter_windows/model/hint/HintData.dart';
import 'package:flutter_windows/model/hint/HintDataHandler.dart';
import 'package:flutter_windows/model/stage/StageData.dart';
import 'package:flutter_windows/view/screen/MainScreen.dart';
import 'package:provider/provider.dart';

import 'controller/data/ModbusHandler.dart';
import 'controller/io.dart';
import 'controller/room/flight_room/handler/FlightEquipmentDataHandler.dart';
import 'model/DataHandler.dart';
import 'model/DataMaster.dart';
import 'model/action/ActionDataHandler.dart';
import 'model/room/GameDataHandler.dart';

void main() async {
  int pollRate = 500;
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
    GameDataHandler gameDataHandler = FlightRoomGameDataHandler();
    HintDataHandler hintDataHandler = HintDataHandler();
    ActionDataHandler actionDataHandler = ActionDataHandler();

    FlightAlertDataHandler alertDataHandler = FlightAlertDataHandler();
    FlightRoomEquipmentDataHandler equipmentDataHandler = FlightRoomEquipmentDataHandler();
    FlightStageDataHandler puzzleDataHandler = FlightStageDataHandler();

    // Extract Room Information
    Map<String, String> roomInfo = await ExtractRoomInfo(id);
    // Extract Equipment Data List
    List<List<String>> equipmentDataList = await ExtractEquipmentDataList(id);
    // Extract Puzzle Data List
    List<List<String>> puzzleDataList = await ExtractPuzzleDataList(id);
    // Extract Alert Data List
    List<List<String>> alertDataList = await ExtractAlertDataList(id);
    // Extract Hint Data List
    List<List<String>> hintDataList = await ExtractHintDataList(id);

    // Parse and Add Room Information
    gameDataHandler.addGame(roomInfo);
    // Parse and Add Equipment Data List
    equipmentDataHandler.addEquipment(equipmentDataList);
    EquipmentDataSource equipmentDataSource = EquipmentDataSource(equipmentStates: equipmentDataHandler.equipmentDataList);
    equipmentDataHandler.equipmentDataSource = equipmentDataSource;
    // Parse and Add Puzzle Data List
    puzzleDataHandler.addStage(puzzleDataList);
    StageDataSource puzzleDataSource = StageDataSource(stageDataList: puzzleDataHandler.stageDataList);
    puzzleDataHandler.dataSource = puzzleDataSource;
    // Parse and Add Alert Data List
    alertDataHandler.addAlertReference(alertDataList);
    AlertDataSource alertDataSource = AlertDataSource(alerts: alertDataHandler.activeAlertList);
    alertDataHandler.alertDataSource = alertDataSource;
    // Parse and Add Hint Data List
    hintDataHandler.addHint(hintDataList);
    HintDataSource hintDataSource = HintDataSource(hintStates: hintDataHandler.hintDataList);
    hintDataHandler.hintDataSource = hintDataSource;



    // Initialize Data Handler
    DataHandler dataHandler = DataHandler(
      roomID: id,
      actionDataHandler: actionDataHandler,
      alertDataHandler: alertDataHandler,
      equipmentDataHandler: equipmentDataHandler,
      stageDataHandler: puzzleDataHandler,
      gameDataHandler: gameDataHandler,
      hintDataHandler: hintDataHandler,
    );

    // Initialize Controllers
    FlightGameController gameController = FlightGameController(
      ip: gameDataHandler.getGame().ip,
      gameData: gameDataHandler.getGame(),
      modbusHandler: modbusHandler,
    );

    // Create Logging Data Source
    GameControlDataSource gameControlDataSource = GameControlDataSource(gameControlDataList: []);
    gameController.gameControlDataSource = gameControlDataSource;

    // Initialize Data Controller
    DataControllerManager dataControllerManager = DataControllerManager(
      gameDataController: gameController,
    );

    // Get IP address of this connection server
    String ip = dataHandler.gameDataHandler.getGame().ip;
    // Create modbus connection
    modbusHandler.createModbusConnection(
      server: new MBServer(ip),
      readOnly: false,
      coilReadSize: 1000, coilStartAddress: 0,
      discreteInputReadSize: 1000, discreteInputStartAddress: 0,
      holdingRegisterReadSize: 1, holdingRegisterStartAddress: 0,
      inputRegisterReadSize: 50, inputRegisterStartAddress: 0,
      pollRate: pollRate,
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
      dataHandler.mbHandler = modbusHandler;

      // Add room data handler to master
      master.addDataHandler(id, dataHandler);
      master.addDataControllerManager(id, dataControllerManager);
    }
    else{
      print("Debug: Connection Exception - Cannot establish connection with IP address $ip");
    }
  }
  Timer(Duration(seconds: 1), (){
    print("CONNECTED");
    modbusHandler.startPoll();
  });

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

