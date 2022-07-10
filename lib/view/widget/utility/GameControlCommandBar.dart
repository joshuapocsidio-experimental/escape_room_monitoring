import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_windows/model/game/GameControlData.dart';
import 'package:flutter_windows/model/game/GameDataController.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:flutter_windows/view/widget/utility/GenericConfirmationDialogPopup.dart';

class GameControlCommandBar extends StatefulWidget {
  final GameDataController gameController;

  GameControlCommandBar({required this.gameController});

  @override
  _GameControlCommandBarState createState() => _GameControlCommandBarState();
}

class _GameControlCommandBarState extends State<GameControlCommandBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "Game Controls",
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
                  label: const Text("See Game Controls Guide"),
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
                callback: widget.gameController.addGameStartLog,
                message: "Game start command will be executed and timer will begin from ${widget.gameController.gameData.maxTime}:00."
                    "\nAll equipment and stages must be ready for a successful start."
                    "\nDo you wish to proceed?",
              ),
              const CommandBarSeparator(),
              buildCommandBarButton(context,
                enable: widget.gameController.gameData.running,
                enabledColor: Colors.red,
                label: "Stop",
                enabledIconData: FluentIcons.stop,
                callback: widget.gameController.addGameStopLog,
                message: "Game stop command will be executed and timer will revert to 00:00."
                    "\nGame states and timer will not be saved."
                    "\nAll equipment will be returned to their deactivated states."
                    "\nDo you wish to proceed?",
              ),
              const CommandBarSeparator(),
              buildCommandBarButton(context,
                enable: !widget.gameController.gameData.running,
                enabledColor: Colors.orange,
                label: "Reset",
                enabledIconData: FluentIcons.reset,
                callback: widget.gameController.addGameResetLog,
                message: "Game reset command will be executed."
                    "\nAll equipment will be engaged to their initial game states."
                    "\nThis may take some time depending on automated equipment in use."
                    "\nDo you wish to proceed?",
              ),
              const CommandBarSeparator(),
            ],
          ),
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
