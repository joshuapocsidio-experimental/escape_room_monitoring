import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/model/puzzle/PuzzleData.dart';
import 'package:flutter_windows/view/widget/room/game/GameStateOverview.dart';
import '../../../../model/puzzle/PuzzleDataHandler.dart';
import 'GameEquipmentDataTable.dart';
import 'GameStateDataTable.dart';
import 'package:flutter_windows/view/widget/RoomStageGridView.dart';

class GameStateCard extends StatefulWidget {
  late final EquipmentDataHandler equipmentDataHandler;
  late final PuzzleDataHandler puzzleDataHandler;

  GameStateCard({required this.equipmentDataHandler, required this.puzzleDataHandler});

  @override
  _GameStateCardState createState() => _GameStateCardState();
}

class _GameStateCardState extends State<GameStateCard> {
  bool _isChecked = false;
  String _stateType = "Puzzles";
  late Widget _dataTable;

  void toggleGameState(bool state){
    setState(() {
      if(_isChecked == false) {
        _isChecked = true;
        _stateType = "Devices";
        _dataTable = GameEquipmentDataTable(equipmentDataHandler: widget.equipmentDataHandler);
      }
      else {
        _isChecked = false;
        _stateType = "Puzzles";
        _dataTable = GameStateDataTable(puzzleDataHandler: widget.puzzleDataHandler);
      }

    });
  }

  @override
  void initState() {
    _dataTable = GameStateDataTable(puzzleDataHandler: widget.puzzleDataHandler);
//    _dataTable = GameEquipmentDataTable(equipmentDataHandler: widget.equipmentDataHandler);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Acrylic(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    luminosityAlpha: 0,
    tintAlpha: 0,
    blurAmount: 500,
    elevation: 20,
      child: Column(
        children: [
          Expanded(
            child: GameStateOverview(),
          ),
          Divider(),
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
          Expanded(
            flex: 2,
            child: _dataTable,
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
      child: Center(
        child: Text("Could not load data handlers for puzzles and devices."),
      ),
    );
  }
}
