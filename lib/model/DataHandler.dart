import '../controller/data/ModbusObserver.dart';
import 'package:flutter_windows/model/DataObserver.dart';
import 'package:flutter_windows/model/alert/AlertDataHandler.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/model/puzzle/PuzzleDataHandler.dart';
import 'package:flutter_windows/model/room/RoomDataHandler.dart';

import '../controller/data/ModbusHandler.dart';
import 'action/ActionDataHandler.dart';

class DataHandler extends ModbusObserver{
  late final MBHandler mbHandler;
  final ActionDataHandler actionDataHandler;
  final AlertDataHandler alertDataHandler;
  final EquipmentDataHandler equipmentDataHandler;
  final PuzzleDataHandler puzzleDataHandler;
  final RoomDataHandler roomDataHandler;

  final String roomID;

  DataHandler({required this.roomID, required this.actionDataHandler, required this.alertDataHandler, required this.equipmentDataHandler, required this.puzzleDataHandler, required this.roomDataHandler});

/// Obtained via Modbus Communication
/// - Alerts
/// - Equipment state
/// - Puzzle state
/// - Room state

  @override
  void update(List<bool> data) {
    super.update(data);

    equipmentDataHandler.updateData(data);
    puzzleDataHandler.updateData(data);
  }

}