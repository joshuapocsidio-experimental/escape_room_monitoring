import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/DataHandler.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:flutter_windows/view/widget/room/game/GameStateOverview.dart';
import '../../../../model/puzzle/PuzzleDataHandler.dart';
import 'GameEquipmentDataTable.dart';
import 'GameStateDataTable.dart';

class GameStateCard extends StatefulWidget {
  @override
  _GameStateCardState createState() => _GameStateCardState();
}

class _GameStateCardState extends State<GameStateCard> {
  bool _isChecked = false;
  String _stateType = "Puzzles";


  void toggleGameState(bool state){
    setState(() {
      _isChecked = state;
      if(_isChecked == true) {
        _stateType = "Devices";
//        _dataTable = _equipDataTable;
      }
      else {
        _stateType = "Puzzles";
//        _dataTable = _puzzleDataTable;
      }

    });
  }

  @override
  void initState() {
//    _puzzleDataTable = GameStateDataTable(puzzleDataHandler: widget.puzzleDataHandler);
//    _equipDataTable = GameEquipmentDataTable(equipmentDataHandler: widget.equipmentDataHandler);
//    _dataTable = _puzzleDataTable;
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
              puzzleDataHandler: dataHandler.puzzleDataHandler,
              equipmentDataHandler: dataHandler.equipmentDataHandler,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ToggleSwitch(
                  checked: _isChecked,
                  onChanged: toggleGameState,
                  content: Text(_stateType),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          Expanded(
            flex: 1,
            child: ContextMenuOverlay(
              child: _isChecked == false
                  ? GameStateDataTable(puzzleDataHandler: dataHandler.puzzleDataHandler)
                  : GameEquipmentDataTable(equipmentDataHandler: dataHandler.equipmentDataHandler)),
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
        child: Text("Could not load data handlers for puzzles and devices."),
      ),
    );
  }
}
