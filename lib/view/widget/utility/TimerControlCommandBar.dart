import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/game/GameDataController.dart';
import 'package:flutter_windows/model/room/GameDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:flutter_windows/view/widget/utility/GenericCommandBarButton.dart';
import 'package:flutter_windows/view/widget/utility/GenericConfirmationDialogPopup.dart';

class TimerControlCommandBar extends StatefulWidget {
  final GameDataController gameController;

  TimerControlCommandBar({required this.gameController});

  @override
  _TimerControlCommandBarState createState() => _TimerControlCommandBarState();
}

class _TimerControlCommandBarState extends State<TimerControlCommandBar> {
  late final TextEditingController _addTextEditingController;
  bool editTextEnable = false;

  @override
  void initState() {
    _addTextEditingController = TextEditingController(
      text: "${widget.gameController.timerChangeMinutes} minutes",
    );

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                  const CommandBarSeparator(),
                  buildCommandBarButton(context,
                    enable: !widget.gameController.gameData.running,
                    enabledColor: Colors.green,
                    label: "Play",
                    enabledIconData: FluentIcons.play,
                    callback: widget.gameController.addTimerStopLog,
                    message: widget.gameController.gameData.running == true ?
                    "Timer start command will be executed."
                        "\nTimer will be resumed at ${widget.gameController.gameData.currTime}"
                        "\nDo you wish to proceed?" :
                    "Timer start command will be executed."
                        "\nTimer countdown still start at ${widget.gameController.gameData.currTime}"
                        "\nDo you wish to proceed?",
                  ),
                  const CommandBarSeparator(),
                  buildCommandBarButton(context,
                    enable: widget.gameController.gameData.running,
                    enabledColor: Colors.orange,
                    label: "Stop",
                    enabledIconData: FluentIcons.stop,
                    message: "Timer stop command will be executed."
                        "\nTimer countdown will stop at ${widget.gameController.gameData.currTime}"
                        "\nDo you wish to proceed?",
                    callback: widget.gameController.addTimerStopLog,
                  ),
                  const CommandBarSeparator(),
                  buildCommandBarButton(context,
                    enable: !widget.gameController.gameData.running,
                    enabledColor: Colors.red,
                    label: "Reset",
                    enabledIconData: FluentIcons.reset,
                    message: "Timer reset command will be executed."
                        "\nTimer countdown will be set at ${widget.gameController.gameData.maxTime}:00."
                        "\nDo you wish to proceed?",
                    callback: widget.gameController.addTimerResetLog,
                  ),
                  const CommandBarSeparator(),
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
                      int addMinutes = widget.gameController.timerChangeMinutes;
                      widget.gameController.addTimerAddTimeLog(addMinutes);
                    },
                  ),
                  const CommandBarSeparator(),
                  CommandBarButton(
                    icon: const Icon(FluentIcons.calculator_subtract),
                    label: const Text("Sub"),
                    onPressed: () {
                      int subMinutes = widget.gameController.timerChangeMinutes;
                      widget.gameController.addTimerSubtractTimeLog(subMinutes);
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
                      _addTextEditingController.text = "${widget.gameController.timerChangeMinutes} minutes";
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
                    if(widget.gameController.timerChangeMinutes > 60) {
                      return;
                    }
                    widget.gameController.timerChangeMinutes++;
                    _addTextEditingController.text = "${widget.gameController.timerChangeMinutes} minutes";
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
                    if(widget.gameController.timerChangeMinutes == 0) {
                      return;
                    }

                    widget.gameController.timerChangeMinutes++;
                    _addTextEditingController.text = "${widget.gameController.timerChangeMinutes} minutes";
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
                      _addTextEditingController.text = "${widget.gameController.timerChangeMinutes}";
                    }
                    else{
                      _addTextEditingController.text = "${widget.gameController.timerChangeMinutes} minutes";
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
  CommandBarButton buildCommandBarButton (BuildContext context,
      {String tooltip = '', required bool enable, required String label, required IconData enabledIconData, required String message, required Function callback, required Color enabledColor,
      }){
    if(tooltip == '') tooltip = label;

    if(enable == false) {
      return CommandBarButton(
          icon: Tooltip(
            child: Icon(FluentIcons.blocked,
              color: Colors.grey.withAlpha(80),
            ),
            message: tooltip,
          ),
          label: Text(label, style: const TextStyle(color: Colors.grey)),
          onPressed: null);
    }
    else{
      return CommandBarButton(
          icon: Icon(enabledIconData, color: enabledColor,),
          label: Text(label, style: const TextStyle(color: Colors.black)),
          onPressed: () {
            showDialog(context: context, builder: (context){
              return GenericConfirmationDialogPopup(
                title: "$label Command - Are you sure?",
                message: message,
                callback: callback,
              );
            });
          });
    }
  }
}

