
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/model/room/GameData.dart';
import 'package:flutter_windows/model/room/GameDataHandler.dart';
import 'package:flutter_windows/model/stage/StageDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:flutter_windows/view/widget/room/overview/room/RoomInterlockStatusTile.dart';

class RoomInterlockView extends StatefulWidget {
  @override
  _RoomInterlockViewState createState() => _RoomInterlockViewState();
}

class _RoomInterlockViewState extends State<RoomInterlockView> {
  late GameDataHandler _gameDataHandler;
  late StageDataHandler _stageDataHandler;
  late EquipmentDataHandler _equipmentDataHandler;
  void _refreshInterlocks() {
    setState(() {

    });
  }

  @override
  void dispose() {
    _gameDataHandler.removeCallback(_refreshInterlocks);
    _equipmentDataHandler.removeCallback(_refreshInterlocks);
    _stageDataHandler.removeCallback(_refreshInterlocks);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _gameDataHandler = RoomPage.of(context).dataHandler.gameDataHandler;
    _equipmentDataHandler = RoomPage.of(context).dataHandler.equipmentDataHandler;
    _stageDataHandler = RoomPage.of(context).dataHandler.stageDataHandler;

    GameData gameData = _gameDataHandler.getGame();

    _gameDataHandler.addCallback(_refreshInterlocks);
    _equipmentDataHandler.addCallback(_refreshInterlocks);
    _stageDataHandler.addCallback(_refreshInterlocks);

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Text("Start Requirements", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),),
              RoomInterlockStatusTile(
                  healthyTitle: "Game State Ready",
                  unhealthyTitle: "Game State Not Ready",
                  healthyState: gameData.gameReady || (gameData.state == GameState.Standby),
              ),
              RoomInterlockStatusTile(
                  healthyTitle: "All Stages Ready",
                  unhealthyTitle: "Stages Not Ready",
                  healthyState: _gameDataHandler.getGame().stagesReady || (gameData.state == GameState.Standby),
              ),
              RoomInterlockStatusTile(
                  healthyTitle: "All Equipment Ready",
                  unhealthyTitle: "Equipment Not Ready",
                  healthyState: _gameDataHandler.getGame().equipmentReady || (gameData.state == GameState.Standby),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              color: Colors.grey.withAlpha(80),
              width: 1,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Text("All Stages Status", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),),
              RoomInterlockStatusTile(healthyTitle: "All Stages OK", unhealthyTitle: "Stages Faulted", healthyState: _gameDataHandler.getGame().stagesHealthy),
              RoomInterlockStatusTile(healthyTitle: "Stage 01 OK", unhealthyTitle: "Stage 01 Faulted", healthyState: !_stageDataHandler.stageDataMap['01']!.isFaulted),
              RoomInterlockStatusTile(healthyTitle: "Stage 04 OK", unhealthyTitle: "Stage 04 Faulted", healthyState: !_stageDataHandler.stageDataMap['04']!.isFaulted),
              RoomInterlockStatusTile(healthyTitle: "Stage 05 OK", unhealthyTitle: "Stage 05 Faulted", healthyState: !_stageDataHandler.stageDataMap['05']!.isFaulted),
              RoomInterlockStatusTile(healthyTitle: "Stage 06 OK", unhealthyTitle: "Stage 06 Faulted", healthyState: !_stageDataHandler.stageDataMap['06']!.isFaulted),
              RoomInterlockStatusTile(healthyTitle: "Stage 08 OK", unhealthyTitle: "Stage 08 Faulted", healthyState: !_stageDataHandler.stageDataMap['08']!.isFaulted),
              RoomInterlockStatusTile(healthyTitle: "Stage 09 OK", unhealthyTitle: "Stage 09 Faulted", healthyState: !_stageDataHandler.stageDataMap['09']!.isFaulted),
              RoomInterlockStatusTile(healthyTitle: "Stage 11 OK", unhealthyTitle: "Stage 11 Faulted", healthyState: !_stageDataHandler.stageDataMap['11']!.isFaulted),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              color: Colors.grey.withAlpha(80),
              width: 1,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Text("All Equipment Status", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),),
              RoomInterlockStatusTile(
                  healthyTitle: "All Equipment OK",
                  unhealthyTitle: "Equipment Faulted",
                  healthyState: _gameDataHandler.getGame().equipmentHealthy
              ),
              RoomInterlockStatusTile(
                  healthyTitle: "Keypad Panel Door OK",
                  unhealthyTitle: "Keypad Panel Door Fault",
                  healthyState: !_equipmentDataHandler.equipmentDataMap['DS001']!.faulted && !_equipmentDataHandler.equipmentDataMap['DL001']!.faulted
              ),
              RoomInterlockStatusTile(
                  healthyTitle: "Overhead Cabinet Door OK",
                  unhealthyTitle: "Overhead Cabinet Door Fault",
                  healthyState: !_equipmentDataHandler.equipmentDataMap['DS002']!.faulted && !_equipmentDataHandler.equipmentDataMap['DL002']!.faulted
              ),
              RoomInterlockStatusTile(
                  healthyTitle: "Antidote Panel Door OK",
                  unhealthyTitle: "Antidote Panel Door Fault",
                  healthyState: !_equipmentDataHandler.equipmentDataMap['DS003']!.faulted && !_equipmentDataHandler.equipmentDataMap['DL003']!.faulted
              ),
              RoomInterlockStatusTile(
                  healthyTitle: "Lever Panel Door OK",
                  unhealthyTitle: "Lever Panel Door Fault",
                  healthyState: !_equipmentDataHandler.equipmentDataMap['DS004']!.faulted && !_equipmentDataHandler.equipmentDataMap['DL004']!.faulted
              ),
              RoomInterlockStatusTile(
                  healthyTitle: "Exit Door OK",
                  unhealthyTitle: "Exit Door Fault",
                  healthyState: !_equipmentDataHandler.equipmentDataMap['DS005']!.faulted && !_equipmentDataHandler.equipmentDataMap['DL005']!.faulted
              ),
              RoomInterlockStatusTile(
                  healthyTitle: "Test Tube Table Limit Switches OK",
                  unhealthyTitle: "Test Tube Table Limit Switches Fault",
                  healthyState: !_equipmentDataHandler.equipmentDataMap['LS001']!.faulted && !_equipmentDataHandler.equipmentDataMap['LS002']!.faulted
              ),
            ],
          ),
        ],
      ),
    );
  }
}


//Table(
//children: [
//TableRow(
//children: [
//RoomInterlockStatusTile(
//healthyTitle: "Game Ready",
//unhealthyTitle: "Game Not Ready",
//healthyState: gameData.gameReady,
//),
//RoomInterlockStatusTile(
//healthyTitle: "Stages Ready",
//unhealthyTitle: "Stages Not Ready",
//healthyState: gameData.stagesReady,
//),
//RoomInterlockStatusTile(
//healthyTitle: "Equipment Ready",
//unhealthyTitle: "Equipment Not Ready",
//healthyState: gameData.equipmentReady,
//),
//RoomInterlockStatusTile(
//healthyTitle: "Game Ready",
//unhealthyTitle: "Game Not Ready",
//healthyState: gameData.gameReady,
//),
//],
//),
//TableRow(
//children: [
//RoomInterlockStatusTile(
//healthyTitle: "Game Ready",
//unhealthyTitle: "Game Not Ready",
//healthyState: gameData.gameReady,
//),
//RoomInterlockStatusTile(
//healthyTitle: "Stages Ready",
//unhealthyTitle: "Stages Not Ready",
//healthyState: gameData.stagesReady,
//),
//RoomInterlockStatusTile(
//healthyTitle: "Equipment Ready",
//unhealthyTitle: "Equipment Not Ready",
//healthyState: gameData.equipmentReady,
//),
//RoomInterlockStatusTile(
//healthyTitle: "Game Ready",
//unhealthyTitle: "Game Not Ready",
//healthyState: gameData.gameReady,
//),
//],
//),
//],
//);