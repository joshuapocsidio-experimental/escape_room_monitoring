import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';

class GameControlCommandBar extends StatefulWidget {
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
              CommandBarButton(
                icon: const Icon(FluentIcons.play),
                label: const Text("Play"),
                onPressed: () {

                },
              ),
              const CommandBarSeparator(),
              CommandBarButton(
                icon: const Icon(FluentIcons.pause),
                label: const Text("Pause"),
                onPressed: () {

                },
              ),
              const CommandBarSeparator(),
              CommandBarButton(
                icon: const Icon(FluentIcons.stop),
                label: const Text("Stop"),
                onPressed: () {

                },
              ),
              const CommandBarSeparator(),
              CommandBarButton(
                icon: const Icon(FluentIcons.play_resume),
                label: const Text("Resume"),
                onPressed: () {

                },
              ),
              const CommandBarSeparator(),
              CommandBarButton(
                icon: const Icon(FluentIcons.reset),
                label: const Text("Reset"),
                onPressed: () {

                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
