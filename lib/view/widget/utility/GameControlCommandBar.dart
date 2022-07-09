import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_windows/model/game/GameControlDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';

class GameControlCommandBar extends StatefulWidget {
  @override
  _GameControlCommandBarState createState() => _GameControlCommandBarState();
}

class _GameControlCommandBarState extends State<GameControlCommandBar> {
  late GameControlDataHandler gameControlDataHandler;
  @override
  Widget build(BuildContext context) {
    RoomPage roomPage = RoomPage.of(context);
    gameControlDataHandler = roomPage.dataHandler.gameControlDataHandler;
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
              CommandBarButton(
                icon: const Icon(FluentIcons.play),
                label: const Text("Start"),
                onPressed: () {
                  gameControlDataHandler.addGameStartLog();
                },
              ),
              const CommandBarSeparator(),
              CommandBarButton(
                icon: const Icon(FluentIcons.stop),
                label: const Text("Stop"),
                onPressed: () {
                  gameControlDataHandler.addGameStopLog();
                },
              ),
              const CommandBarSeparator(),
              CommandBarButton(
                icon: const Icon(FluentIcons.reset),
                label: const Text("Reset"),
                onPressed: () {
                  gameControlDataHandler.addGameResetLog();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
