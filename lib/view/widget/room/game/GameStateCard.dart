import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/DataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:flutter_windows/view/widget/room/game/GameStateOverview.dart';

import 'equipment/EquipmentDataTable.dart';
import 'stage/StageDataTable.dart';

class GameStateCard extends StatefulWidget {
  @override
  _GameStateCardState createState() => _GameStateCardState();
}

class _GameStateCardState extends State<GameStateCard> {
  bool _isChecked = false;
  String _stateType = "Stages";


  void toggleGameState(bool state){
    setState(() {
      _isChecked = state;
      if(_isChecked == true) {
        _stateType = "Devices";
      }
      else {
        _stateType = "Stages";
      }

    });
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    DataHandler dataHandler = RoomPage.of(context).dataHandler;
    return Card(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: GameStateOverview(
              puzzleDataHandler: dataHandler.stageDataHandler,
              equipmentDataHandler: dataHandler.equipmentDataHandler,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ToggleSwitch(
                checked: _isChecked,
                onChanged: toggleGameState,
                content: Text(_stateType),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ContextMenuOverlay(
              child: _isChecked == false
                  ? StageDataTable(puzzleDataHandler: dataHandler.stageDataHandler)
                  : EquipmentDataTable(equipmentDataHandler: dataHandler.equipmentDataHandler)),
          ),
        ],
      ),
    );
  }
}

class InvalidGameStateCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text("Could not load data handlers for stages and devices."),
      ),
    );
  }
}
