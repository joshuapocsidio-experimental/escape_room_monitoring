import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/room/control/RoomTabularControlCard.dart';
import 'package:provider/provider.dart';
import '../../../../handlers/RoomStateHandler.dart';
import '../../../../model/RoomStateData.dart';
import '../../../widget/room/game/GameStateCard.dart';
import '../../../widget/room/alert/RoomTabularAlarmCard.dart';
import '../../../widget/room/summary/RoomTabularSummaryCard.dart';

class FlightRoomTabularPage extends StatefulWidget {
  @override
  _FlightRoomTabularPageState createState() => _FlightRoomTabularPageState();
}

class _FlightRoomTabularPageState extends State<FlightRoomTabularPage> {
  @override
  Widget build(BuildContext context) {
    RoomStateData roomStateData = Provider.of<RoomStateHandler>(context).rooms[0];
    return Container(
      color: Colors.grey.withAlpha(10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8, bottom: 4, right: 4),
                    child: RoomTabularSummaryCard(
                      roomName: roomStateData.name,
                      id: roomStateData.id,
                      color: Colors.yellow,
                      maxMin: roomStateData.maxTime,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 4),
                    child: RoomTabularControlCard(),
                  ),
                ),
                Expanded(
                  flex: 3,
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
