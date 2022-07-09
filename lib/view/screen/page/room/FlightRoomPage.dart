import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/room/log/RoomLogCard.dart';

import '../../../widget/room/alert/RoomAlertCard.dart';
import '../../../widget/room/game/GameStateCard.dart';
import '../../../widget/room/overview/room/RoomOverviewCard.dart';

class FlightRoomPage extends StatefulWidget {
  final String roomName;
  final String roomID;
  final String maxTime;

  FlightRoomPage({required this.roomName, required this.roomID, required this.maxTime});

  @override
  _FlightRoomPageState createState() => _FlightRoomPageState();
}

class _FlightRoomPageState extends State<FlightRoomPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(30),
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 4, right: 4),
                        child: RoomOverviewCard(),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 4, right: 4),
                          child: RoomLogCard(),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, top: 8, bottom: 8, right: 8),
                    child: GameStateCard(
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 8, right: 4),
              child:
              RoomAlertCard(),
            ),
          ),
        ],
      ),
    );
  }
}
