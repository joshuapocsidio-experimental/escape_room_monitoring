import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/game/GameDataController.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:flutter_windows/view/widget/room/log/gameControl/GameControlDataTable.dart';

class GameControlLogCard extends StatefulWidget {
  @override
  _GameControlLogCardState createState() => _GameControlLogCardState();
}

class _GameControlLogCardState extends State<GameControlLogCard> {
  late GameDataController gameController;
  @override
  Widget build(BuildContext context) {
    gameController = RoomPage.of(context).dataControllerManager.gameDataController;
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
                  gameController.gameControlDataList.clear();
                  gameController.notifyCallbacks();
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
