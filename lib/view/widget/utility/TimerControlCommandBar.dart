import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/game/GameControlDataHandler.dart';
import 'package:flutter_windows/model/room/GameDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';

class TimerControlCommandBar extends StatefulWidget {
  @override
  _TimerControlCommandBarState createState() => _TimerControlCommandBarState();
}

class _TimerControlCommandBarState extends State<TimerControlCommandBar> {
  late final TextEditingController _addTextEditingController;
  late GameControlDataHandler gameControlDataHandler;
  late GameDataHandler roomDataHandler;
  int changeMinute = 5;
  bool editTextEnable = false;

  @override
  void initState() {
    _addTextEditingController = TextEditingController(
      text: "$changeMinute minutes",
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    gameControlDataHandler = RoomPage.of(context).dataHandler.gameControlDataHandler;
    roomDataHandler = RoomPage.of(context).dataHandler.gameDataHandler;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  "Timer Controls",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: CommandBar(
                isCompact: false,
                mainAxisAlignment: MainAxisAlignment.start,
                secondaryItems: [
                  CommandBarButton(
                      icon: const Icon(FluentIcons.info),
                      label: const Text("See Timer Controls Guide"),
                      onPressed: () {

                      }
                  )
                ],
                primaryItems: [
                  CommandBarButton(
                    icon: const Icon(FluentIcons.play),
                    label: const Text("Play"),
                    onPressed: () {
                      String timeStamp = '';
                      if(roomDataHandler.getGame().running == true){
                        timeStamp = roomDataHandler.getGame().currTime;
                      }
                      gameControlDataHandler.addTimerStartLog(timeStamp);
                    },
                  ),
                  const CommandBarSeparator(),
                  CommandBarButton(
                    icon: const Icon(FluentIcons.stop),
                    label: const Text("Stop"),
                    onPressed: () {
                      gameControlDataHandler.addTimerStopLog(roomDataHandler.getGame().currTime);
                    },
                  ),
                  const CommandBarSeparator(),
                  CommandBarButton(
                    icon: const Icon(FluentIcons.reset),
                    label: const Text("Reset"),
                    onPressed: () {
                      gameControlDataHandler.addTimerResetLog();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CommandBar(
                mainAxisAlignment: MainAxisAlignment.end,
                primaryItems: [
                  CommandBarButton(
                    icon: const Icon(FluentIcons.add),
                    label: const Text("Add"),
                    onPressed: () {
                      gameControlDataHandler.addTimerAddTimeLog(changeMinute);
                    },
                  ),
                  const CommandBarSeparator(),
                  CommandBarButton(
                    icon: const Icon(FluentIcons.calculator_subtract),
                    label: const Text("Sub"),
                    onPressed: () {
                      gameControlDataHandler.addTimerSubtractTimeLog(changeMinute);
                    },
                  ),
                  const CommandBarSeparator(),
                ],

              ),
            ),
            SizedBox(
              width: 100,
              child: TextBox(
                controller: _addTextEditingController,
                onEditingComplete: (){
                  setState(() {
                    String minString = _addTextEditingController.text;
                    if(int.tryParse(minString) != null) {
                      _addTextEditingController.text = "$minString minutes";
                    }
                    else{
                      _addTextEditingController.text = "$changeMinute minutes";
                    }
                    editTextEnable = false;
                  });
                },
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                enabled: editTextEnable,
              ),
            ),
            SizedBox(
              width: 30,
              child: OutlinedButton(
                onPressed: editTextEnable == true ? null : () {
                  setState(() {
                    if(changeMinute > 60) {
                      return;
                    }
                    changeMinute++;
                    _addTextEditingController.text = "$changeMinute minutes";
                  });
                },
                child: const Icon(
                  FluentIcons.up,
                  size: 10,
                ),
              ),
            ),
            SizedBox(
              width: 30,
              child: OutlinedButton(
                onPressed: editTextEnable == true ? null : () {
                  setState(() {
                    if(changeMinute == 0) {
                      return;
                    }

                    changeMinute++;
                    _addTextEditingController.text = "$changeMinute minutes";
                  });
                },
                child: const Icon(
                  FluentIcons.down,
                  size: 10,
                ),
              ),
            ),
            SizedBox(
              width: 30,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    editTextEnable = !editTextEnable;
                    if(editTextEnable == true) {
                      _addTextEditingController.text = "$changeMinute";
                    }
                    else{
                      _addTextEditingController.text = "$changeMinute minutes";
                    }
                  });
                },
                child: const Icon(
                  FluentIcons.pencil_reply,
                  size: 10,
                ),
              ),
            ),

          ],
        ),
      ],
    );
  }
}
