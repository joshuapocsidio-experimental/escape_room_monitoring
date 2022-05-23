import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/model/puzzle/PuzzleDataHandler.dart';
import 'package:flutter_windows/view/widget/room/overview/RoomOverviewGridView.dart';

class RoomOverviewCard extends StatefulWidget {
  final String roomName;
  final PuzzleDataHandler puzzleDataHandler;
  final EquipmentDataHandler equipmentDataHandler;

  RoomOverviewCard({required this.roomName, required this.puzzleDataHandler, required this.equipmentDataHandler});

  @override
  _RoomOverviewCardState createState() => _RoomOverviewCardState();
}

class _RoomOverviewCardState extends State<RoomOverviewCard> {
  bool _isChecked = false;
  String _stateType = "Puzzles";
  int? _numColumns = 10;

  void toggleGameState(bool state){
    setState(() {
      if(_isChecked == false) {
        _isChecked = true;
        _stateType = "Devices";
      }
      else {
        _isChecked = false;
        _stateType = "Puzzles";
      }

    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          backgroundColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: ListTile(
                  isThreeLine: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 4),
                  leading: Icon(
                    FluentIcons.play_solid,
                    color: Colors.green,
                    size: 30,
                  ),
                  subtitle: Center(
                    child: const Text(
                      "36:00/60:00",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  title: Expanded(
                    child: Center(
                      child: Text(
                        widget.roomName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  trailing: Row(
                    children: [
                      IconButton(
                        icon: const Icon(FluentIcons.room),
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (context){
                              return ContentDialog(
                                title: Text("Navigate to '${widget.roomName}'"),
                                content: Text("Please confirm you would like to navigate to '${widget.roomName}' page?"),
                                actions: [
                                  Button(child: const Text("Confirm"), onPressed: (){Navigator.pop(context);}),
                                  Button(child: const Text("Cancel"), onPressed: (){Navigator.pop(context);}),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(icon: const Icon(FluentIcons.ringer), onPressed: (){},),
                      IconButton(icon: const Icon(FluentIcons.more), onPressed: (){},),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ToggleSwitch(
                      checked: _isChecked,
                      onChanged: toggleGameState,
                      content: Text(_stateType),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Combobox<int>(
                          placeholder: const Text("Columns"),
                          onTap: (){},
                          value: _numColumns,
                          onChanged: (value){
                            setState(() {
                              debugPrint(value.toString());
                              _numColumns = value;
                            });
                          },
                          items: [
                            ComboboxItem<int>(
                              onTap: (){

                              },
                              value: 5,
                              child: const Text("5"),
                            ),
                            ComboboxItem<int>(
                              onTap: (){

                              },
                              value: 6,
                              child: const Text("6"),
                            ),
                            ComboboxItem<int>(
                              onTap: (){

                              },
                              value: 7,
                              child: const Text("7"),
                            ),
                            ComboboxItem<int>(
                              onTap: (){

                              },
                              value: 8,
                              child: const Text("8"),
                            ),
                            ComboboxItem<int>(
                              onTap: (){

                              },
                              value: 9,
                              child: const Text("9"),
                            ),
                            ComboboxItem<int>(
                              onTap: (){

                              },
                              value: 10,
                              child: const Text("10"),
                            ),
                            ComboboxItem<int>(
                              onTap: (){

                              },
                              value: 11,
                              child: const Text("11"),
                            ),
                            ComboboxItem<int>(
                              onTap: (){

                              },
                              value: 12,
                              child: const Text("12"),
                            ),
                            ComboboxItem<int>(
                              onTap: (){

                              },
                              value: 13,
                              child: const Text("13"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 17,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RoomOverviewGridView(
              toggle: _isChecked,
              numColumns: _numColumns!,
              equipmentDataHandler: widget.equipmentDataHandler,
              puzzleDataHandler: widget.puzzleDataHandler,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("70%"),
                    ),
                ),
                const Expanded(
                  flex: 9,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: ProgressBar(
                      value: 70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
