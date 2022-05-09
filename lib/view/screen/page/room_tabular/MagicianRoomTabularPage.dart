import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/room/control/RoomTabularControlCard.dart';
import 'package:provider/provider.dart';
import '../../../../model/DataHandler.dart';
import '../../../../model/DataMaster.dart';
import '../../../../model/equipment/EquipmentData.dart';
import '../../../../model/equipment/EquipmentDataHandler.dart';
import '../../../../model/puzzle/PuzzleDataHandler.dart';
import '../../../widget/room/game/GameStateCard.dart';
import '../../../widget/room/alert/RoomTabularAlarmCard.dart';
import '../../../widget/room/summary/RoomTabularSummaryCard.dart';

class MagicianRoomTabularPage extends StatefulWidget {
  final String roomName;
  final String roomID;
  final String maxTime;

  MagicianRoomTabularPage({required this.roomName, required this.roomID, required this.maxTime});

  @override
  _MagicianRoomTabularPageState createState() => _MagicianRoomTabularPageState();
}

class _MagicianRoomTabularPageState extends State<MagicianRoomTabularPage> {

  @override
  Widget build(BuildContext context) {
    DataMaster master = Provider.of<DataMaster>(context);
    DataHandler handler = master.getDataHandler("mcrm01");

    EquipmentDataHandler MagicianEquipmentDataHandler = handler.equipmentDataHandler;
    PuzzleDataHandler MagicianPuzzleDataHandler = handler.puzzleDataHandler;
    return Container(
      color: Colors.grey.withAlpha(10),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8, bottom: 4, right: 4),
                    child: RoomTabularSummaryCard(
                      roomName: widget.roomName,
                      id: widget.roomID,
                      color: Colors.yellow,
                      maxMin: widget.maxTime,
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
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.only(left: 4, top: 8, bottom: 8, right: 8),
              child: GameStateCard(
                equipmentDataHandler: MagicianEquipmentDataHandler,
                puzzleDataHandler: MagicianPuzzleDataHandler,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
