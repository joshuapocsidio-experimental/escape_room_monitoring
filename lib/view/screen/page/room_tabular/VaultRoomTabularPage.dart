import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/alert/AlertDataHandler.dart';
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

class VaultRoomTabularPage extends StatefulWidget {
  final String roomName;
  final String roomID;
  final String maxTime;

  VaultRoomTabularPage({required this.roomName, required this.roomID, required this.maxTime});

  @override
  _VaultRoomTabularPageState createState() => _VaultRoomTabularPageState();
}

class _VaultRoomTabularPageState extends State<VaultRoomTabularPage> {

  @override
  Widget build(BuildContext context) {
    DataMaster master = Provider.of<DataMaster>(context);
    DataHandler handler = master.getDataHandler("tvrm01");

    EquipmentDataHandler VaultEquipmentDataHandler = handler.equipmentDataHandler;
    PuzzleDataHandler VaultPuzzleDataHandler = handler.puzzleDataHandler;
    AlertDataHandler vaultAlertDataHandler = handler.alertDataHandler;
    return Container(
      color: Colors.grey.withAlpha(10),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: Column(
              children: [
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
