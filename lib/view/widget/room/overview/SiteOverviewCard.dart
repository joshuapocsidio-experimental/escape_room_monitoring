import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/DataHandler.dart';
import 'package:flutter_windows/model/room/GameDataHandler.dart';
import 'package:flutter_windows/view/screen/MainScreen.dart';
import 'package:provider/provider.dart';

import '../../utility/GameProgressBar.dart';
import '../../utility/GenericStatusTile.dart';
import '../../utility/TimerProgressBar.dart';
import 'SiteOverviewGridView.dart';

class SiteOverviewCard extends StatefulWidget {
  final DataHandler dataHandler;

  SiteOverviewCard({required this.dataHandler});

  @override
  _SiteOverviewCardState createState() => _SiteOverviewCardState();
}

class _SiteOverviewCardState extends State<SiteOverviewCard> {
  bool _isChecked = false;
  String _stateType = "Puzzles";
  int? _numColumns = 10;
  late GameDataHandler _gameDataHandler;

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

  void _refreshInfo() {
    setState(() {
      print("RUNNING FEEDBACK");
    });
  }
  @override
  Widget build(BuildContext context) {
    NavigationHandler navHandler = Provider.of<NavigationHandler>(context);
    _gameDataHandler = widget.dataHandler.gameDataHandler;
    _gameDataHandler.addCallback(_refreshInfo);
    return Card(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: ListTile(
              isThreeLine: true,
              contentPadding: EdgeInsets.symmetric(vertical: 4),
              title: Expanded(
                child: Center(
                  child: Text(
                    _gameDataHandler.getGame().name,
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
                            title: Text("Navigate to '${_gameDataHandler.getGame().name}'"),
                            content: Text("Please confirm you would like to navigate to '${_gameDataHandler.getGame().name}' page?"),
                            actions: [
                              Button(child: const Text("Confirm"), onPressed: (){
                                Navigator.pop(context);
                                navHandler.navigate(_gameDataHandler.getGame().id);
                              }),
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Status",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 16,
                  child: Text(
                    _gameDataHandler.getGame().running == true ? "Running" : "Standby",
                    style: TextStyle(
                      color: _gameDataHandler.getGame().running == true ? Colors.blue : Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: TimerProgressBar(
              progress: _gameDataHandler.getGame().progress,
              maxTime: _gameDataHandler.getGame().maxTime,
              currTimeMin: _gameDataHandler.getGame().currTimeMin,
              currTimeSec: _gameDataHandler.getGame().currTimeSec,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: GameProgressBar(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: GenericStatusTile(
              title: "Audio",
              onStateText: "Playing",
              offStateText: "Standby",
              state: _gameDataHandler.getGame().isAudioPlaying,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: GenericStatusTile(
              title: "Video",
              onStateText: "Playing",
              offStateText: "Standby",
              state: _gameDataHandler.getGame().isVideoPlaying,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(),
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SiteOverviewGridView(
                toggle: _isChecked,
                numColumns: _numColumns!,
                equipmentDataHandler: widget.dataHandler.equipmentDataHandler,
                stageDataHandler: widget.dataHandler.stageDataHandler,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
