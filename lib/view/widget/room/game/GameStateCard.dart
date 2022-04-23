import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/room/game/GameStateOverview.dart';
import 'GameEquipmentDataTable.dart';
import 'GameStateDataTable.dart';
import 'package:flutter_windows/view/widget/RoomStageGridView.dart';

class GameStateCard extends StatefulWidget {
  @override
  _GameStateCardState createState() => _GameStateCardState();
}

class _GameStateCardState extends State<GameStateCard> {
  bool _isChecked = false;
  String _stateType = "Puzzles";
  Widget _dataTable = GameStateDataTable();

  void toggleGameState(bool state){
    setState(() {
      if(_isChecked == false) {
        _isChecked = true;
        _stateType = "Devices";
        _dataTable = GameEquipmentDataTable();
      }
      else {
        _isChecked = false;
        _stateType = "Puzzles";
        _dataTable = GameStateDataTable();
      }

    });
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
