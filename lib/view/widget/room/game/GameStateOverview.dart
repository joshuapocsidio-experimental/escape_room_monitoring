import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/RoomEquipmentGridView.dart';
import 'package:flutter_windows/view/widget/RoomOverviewEquipmentCard.dart';

import '../../RoomStageGridView.dart';
import '../../RoomOverviewStageCard.dart';

class GameStateOverview extends StatefulWidget {
  @override
  _GameStateOverviewState createState() => _GameStateOverviewState();
}

class _GameStateOverviewState extends State<GameStateOverview> {
  bool _isChecked = false;
  String _stateType = "Puzzles";
  int? _numColumns = 10;
  late Widget _gridView;

  final List<Widget> _stageBoxes = [
    RoomOverviewStageCard(color: Colors.green, label: "1",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(15), label: "2",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(15), label: "3",),
    RoomOverviewStageCard(color: Colors.green, label: "4",),
    RoomOverviewStageCard(color: Colors.teal, label: "5",),
    RoomOverviewStageCard(color: Colors.green, label: "6",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(15), label: "7",),
    RoomOverviewStageCard(color: Colors.teal, label: "8",),
    RoomOverviewStageCard(color: Colors.green, label: "9",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(15), label: "10",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "11",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "12",),
  ];

  final List<Widget> _equipmentBoxes = [
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "A", subLabel: "1"),
    RoomOverviewEquipmentCard(color: Colors.blue, label: "B", subLabel: "4"),
    RoomOverviewEquipmentCard(color: Colors.blue, label: "C", subLabel: "5"),
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "D", subLabel: "5"),
    RoomOverviewEquipmentCard(color: Colors.blue, label: "E", subLabel: "6"),
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "F", subLabel: "9"),
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "G", subLabel: "9"),
    RoomOverviewEquipmentCard(color: Colors.red, label: "H", subLabel: "9"),
    RoomOverviewEquipmentCard(color: Colors.red, label: "I", subLabel: "9"),
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "J", subLabel: "9"),
    RoomOverviewEquipmentCard(color: Colors.blue, label: "K", subLabel: "9"),
    RoomOverviewEquipmentCard(color: Colors.blue, label: "L", subLabel: "9"),
    RoomOverviewEquipmentCard(color: Colors.blue, label: "M", subLabel: "9"),
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "N", subLabel: "11"),
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "O", subLabel: "11"),
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "P", subLabel: "11"),
  ];

  void toggleGameState(bool state){
    setState(() {
      if(_isChecked == false) {
        _isChecked = true;
        _stateType = "Physical";
        _gridView = RoomEquipmentGridView(
          equipmentBoxes: _equipmentBoxes,
          numColumns: _numColumns ?? 10,
        );
      }
      else {
        _isChecked = false;
        _stateType = "Puzzles";
        _gridView = RoomStageGridView(
          stageBoxes: _stageBoxes,
          numColumns: _numColumns ?? 10,
        );
      }

    });
  }

  @override
  void initState() {
    _gridView = RoomStageGridView(
      stageBoxes: _stageBoxes,
      numColumns: _numColumns ?? 10,
    );
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
              ToggleSwitch(
                checked: _isChecked,
                onChanged: toggleGameState,
                content: Text(_stateType),
              ),
              Row(
                children: [
                  OutlinedButton(
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
                    child: const Text(
                      "Filter",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Divider(),
                  ),
                  OutlinedButton(
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
                    },
                    child: const Text(
                      "Options",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _isChecked == true ? RoomEquipmentGridView(
              equipmentBoxes: _equipmentBoxes,
              numColumns: _numColumns ?? 10,
            ) : RoomStageGridView(
              stageBoxes: _stageBoxes,
              numColumns: _numColumns ?? 10,
            ),
          ),
        ),
      ],
    );
  }
}
