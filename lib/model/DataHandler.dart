import 'package:flutter_windows/model/alert/AlertDataHandler.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/model/game/GameControlDataHandler.dart';
import 'package:flutter_windows/model/hint/HintDataHandler.dart';
import 'package:flutter_windows/model/room/GameDataHandler.dart';
import 'package:flutter_windows/model/stage/StageDataHandler.dart';

import '../controller/data/ModbusHandler.dart';
import '../controller/data/ModbusObserver.dart';
import 'action/ActionDataHandler.dart';

class DataHandler extends ModbusObserver{
  late final MBHandler mbHandler;
  final ActionDataHandler actionDataHandler;
  final AlertDataHandler alertDataHandler;
  final EquipmentDataHandler equipmentDataHandler;
  final StageDataHandler stageDataHandler;
  final GameDataHandler gameDataHandler;
  final HintDataHandler hintDataHandler;
  final GameControlDataHandler gameControlDataHandler;

  final String roomID;

  DataHandler({
    required this.roomID,
    required this.actionDataHandler,
    required this.alertDataHandler,
    required this.equipmentDataHandler,
    required this.stageDataHandler,
    required this.gameDataHandler,
    required this.hintDataHandler,
    required this.gameControlDataHandler,
  });

/// Obtained via Modbus Communication
/// - Alerts
/// - Equipment state
/// - Puzzle state
/// - Room state

  @override
  void update(List<bool> bits, List<int> registers) {
    super.update(bits, registers);

    equipmentDataHandler.readData(bits, registers);
    stageDataHandler.readData(bits, registers);
    alertDataHandler.readData(bits, registers);
    gameDataHandler.readData(bits, registers);
  }
}