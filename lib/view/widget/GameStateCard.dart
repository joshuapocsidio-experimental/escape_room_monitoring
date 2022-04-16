import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/GameStateDataTable.dart';
import 'package:flutter_windows/view/widget/RoomOverviewGridView.dart';

class GameStateCard extends StatefulWidget {
  @override
  _GameStateCardState createState() => _GameStateCardState();
}

class _GameStateCardState extends State<GameStateCard> {
  @override
  Widget build(BuildContext context) {
    return Acrylic(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    luminosityAlpha: 0,
    tintAlpha: 0,
    blurAmount: 500,
    elevation: 20,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          Container(
            child: Text(
              "Game State",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoomOverviewGridView(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(),
          ),
          Expanded(
            flex: 3,
            child: GameStateDataTable(),
          ),
        ],
      ),
    );
  }
}
