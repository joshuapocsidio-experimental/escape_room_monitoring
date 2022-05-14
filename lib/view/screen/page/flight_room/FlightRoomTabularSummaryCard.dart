import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/room/RoomData.dart';
import 'package:flutter_windows/view/widget/room/summary/RoomTabularSummaryCard.dart';
import 'package:provider/provider.dart';

import '../../../../model/DataMaster.dart';
import '../../../../model/room/RoomDataHandler.dart';

class ElevatorRoomTabularSummaryCard extends StatefulWidget {
  const ElevatorRoomTabularSummaryCard({Key? key}) : super(key: key);

  @override
  _ElevatorRoomTabularSummaryCardState createState() => _ElevatorRoomTabularSummaryCardState();
}

class _ElevatorRoomTabularSummaryCardState extends State<ElevatorRoomTabularSummaryCard> {
  late final DataMaster _dataMaster;
  late final RoomDataHandler _roomDataHandler;
  late final RoomData _roomData;
  @override
  Widget build(BuildContext context) {
    _dataMaster = Provider.of<DataMaster>(context);
    _roomDataHandler = _dataMaster.getDataHandler('flrm01').roomDataHandler;
    _roomData = _roomDataHandler.getRoom();
    // Get room attributes
    String roomName, roomID, maxTime; // TODO: Change maxMin to integer
    roomName = _roomData.name;
    roomID = _roomData.id;
    maxTime = _roomData.maxTime;

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 4, right: 4),
        child: RoomTabularSummaryCard(
          roomName: roomName,
          id: roomID,
          color: Colors.yellow,
          maxMin: maxTime,
        ),
      ),
    );
  }
}
