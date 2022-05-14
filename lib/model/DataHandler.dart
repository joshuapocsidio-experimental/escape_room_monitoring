import 'package:flutter_windows/controller/ModbusObserver.dart';
import 'package:flutter_windows/model/DataObserver.dart';
import 'package:flutter_windows/model/alert/AlertDataHandler.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/model/puzzle/PuzzleDataHandler.dart';
import 'package:flutter_windows/model/room/RoomDataHandler.dart';

import '../controller/ModbusHandler.dart';
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
    // Alerts - Bit 0 to 4 (80 bits)
    List<bool> alertBits = data.getRange(0, 80).toList();
    alertDataHandler.updateData(alertBits);
    // Equipment State - Bit 5 to 9 (80 bits)
    List<bool> equipBits = data.getRange(80, 160).toList();
    equipmentDataHandler.updateData(equipBits);
    // Puzzle State - Bit 10 to 12 (48 bits)
    List<bool> puzzleBits = data.getRange(160, 208).toList();
    puzzleDataHandler.updateData(puzzleBits);
    // Room State - Bit 13 (16 bits)
    List<bool> roomBits = data.getRange(208, 232).toList();
    roomDataHandler.updateData(roomBits);
    // Unallocated - Bit 14 to 19 (96 bits)
    List<bool> unallocated = data.getRange(232, 328).toList();
  }

}