import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/model/puzzle/PuzzleDataHandler.dart';
import 'package:flutter_windows/view/widget/RoomEquipmentGridView.dart';
import 'package:flutter_windows/view/widget/room/overview/RoomOverviewGridView.dart';
import '../overview/RoomOverviewStageCard.dart';

class GameStateOverview extends StatefulWidget {
  final PuzzleDataHandler puzzleDataHandler;
  final EquipmentDataHandler equipmentDataHandler;

  GameStateOverview({required this.puzzleDataHandler, required this.equipmentDataHandler});

  @override
  _GameStateOverviewState createState() => _GameStateOverviewState();
}

class _GameStateOverviewState extends State<GameStateOverview> {
  bool _isChecked = false;
  String _stateType = "Puzzles";
  int? _numColumns = 10;

  void toggleGameState(bool state){
    setState(() {
      if(_isChecked == false) {
        _isChecked = true;
        _stateType = "Physical";
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
      children: [
        ListTile(
          title: const Center(
            child: Text(
              "Game State",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(FluentIcons.more),
            onPressed: () {  },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child : ToggleSwitch(
                  checked: _isChecked,
                  onChanged: toggleGameState,
                  content: Text(_stateType),
                ),
              ),
              Expanded(
                child : CommandBar(
                  mainAxisAlignment: MainAxisAlignment.end,
                  primaryItems: [
                    CommandBarButton(
                      label: Text('Filter'),
                      icon: Icon(FluentIcons.filter),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context){
                            return ContentDialog(
                              title: const Text("Filter"),
                              content: const Text("This is a placeholder and will be replaced once functionality for filter functionality is implemented."),
                              actions: [
                                Button(child: const Text("OK"), onPressed: (){Navigator.pop(context);}),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    CommandBarButton(
                        label: Text('Options'),
                        icon: Icon(FluentIcons.settings),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context){
                              return ContentDialog(
                                constraints: const BoxConstraints(maxWidth: 360, maxHeight: 300),
                                title: const Text("Options"),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Number of box across "),
                                    Combobox<int>(
                                      placeholder: const Text("Columns"),
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
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Button(child: const Text("Confirm"), onPressed: (){Navigator.pop(context);}),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        }
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoomOverviewGridView(
              toggle: _isChecked,
              numColumns: _numColumns!,
              equipmentDataHandler: widget.equipmentDataHandler,
              puzzleDataHandler: widget.puzzleDataHandler,
            ),
          ),
        ),
      ],
    );
  }
}
