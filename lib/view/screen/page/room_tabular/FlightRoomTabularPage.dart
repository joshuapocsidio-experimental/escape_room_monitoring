import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/GameStateCard.dart';
import 'package:flutter_windows/view/widget/RoomTabularAlarmCard.dart';
import 'package:flutter_windows/view/widget/RoomTabularSummaryCard.dart';

class FlightRoomTabularPage extends StatefulWidget {
  @override
  _FlightRoomTabularPageState createState() => _FlightRoomTabularPageState();
}

class _FlightRoomTabularPageState extends State<FlightRoomTabularPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8, bottom: 4, right: 4),
                    child: RoomTabularSummaryCard(
                      roomName: "Flight 729",
                      id: "fl729",
                      color: Colors.yellow,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4, bottom: 8, right: 4),
                    child: RoomTabularAlarmCard(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 4, top: 8, bottom: 8, right: 8),
              child: GameStateCard(),
            ),
          ),
        ],
      ),
    );
  }
}
