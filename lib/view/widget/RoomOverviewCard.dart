import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/RoomEquipmentGridView.dart';
import 'package:flutter_windows/view/widget/RoomStageGridView.dart';
import 'package:flutter_windows/view/widget/RoomOverviewStageCard.dart';

import 'RoomOverviewEquipmentCard.dart';

class RoomOverviewCard extends StatefulWidget {
  late String roomName;

  RoomOverviewCard({required this.roomName});

  @override
  _RoomOverviewCardState createState() => _RoomOverviewCardState();
}

class _RoomOverviewCardState extends State<RoomOverviewCard> {
  bool _isChecked = false;
  String _stateType = "Puzzles";
  int? _numColumns = 10;

  List<Widget> _stageBoxes = [
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

  List<Widget> _equipmentBoxes = [
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
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "K", subLabel: "9"),
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "L", subLabel: "9"),
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "M", subLabel: "9"),
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "N", subLabel: "11"),
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "O", subLabel: "11"),
    RoomOverviewEquipmentCard(color: Colors.grey.withAlpha(70), label: "P", subLabel: "11"),
  ];
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
            child: _isChecked == false ? RoomStageGridView(
              stageBoxes: _stageBoxes,
              numColumns: _numColumns ?? 10,
            ) : RoomEquipmentGridView(
                equipmentBoxes: _equipmentBoxes,
                numColumns: _numColumns ?? 10),
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
