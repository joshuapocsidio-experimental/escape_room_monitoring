import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/view/widget/room/game/GameStateOverview.dart';
import '../../../../model/puzzle/PuzzleDataHandler.dart';
import 'GameEquipmentDataTable.dart';
import 'GameStateDataTable.dart';

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
  late Widget _dataTable, _puzzleDataTable, _equipDataTable;

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
            child: GameStateOverview(
              puzzleDataHandler: widget.puzzleDataHandler,
              equipmentDataHandler: widget.equipmentDataHandler,
            ),
          ),
          const Divider(),
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
            child: _isChecked == false ? GameStateDataTable(puzzleDataHandler: widget.puzzleDataHandler) : GameEquipmentDataTable(equipmentDataHandler: widget.equipmentDataHandler),
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
