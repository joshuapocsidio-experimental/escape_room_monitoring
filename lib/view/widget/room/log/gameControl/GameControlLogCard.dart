import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/room/log/gameControl/GameControlDataTable.dart';

class GameControlLogCard extends StatefulWidget {
  @override
  _GameControlLogCardState createState() => _GameControlLogCardState();
}

class _GameControlLogCardState extends State<GameControlLogCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Text(
            "Game Control Log",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          CommandBar(
            mainAxisAlignment: MainAxisAlignment.start,
            primaryItems: [
              CommandBarButton(
                label: Text('Clear All'),
                icon: Icon(FluentIcons.clear),
                onPressed: () async {
                },
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Divider(),
          ),
          Expanded(
            child: ContextMenuOverlay(
              child: GameControlDataTable(),
            ),
          ),
        ],
      ),
    );
  }
}
