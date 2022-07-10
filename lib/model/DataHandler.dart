import 'dart:async';

import 'package:flutter_windows/model/alert/AlertDataHandler.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/model/game/GameDataController.dart';
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

  final String roomID;

  DataHandler({
    required this.roomID,
    required this.actionDataHandler,
    required this.alertDataHandler,
    required this.equipmentDataHandler,
    required this.stageDataHandler,
    required this.gameDataHandler,
    required this.hintDataHandler,
  });

  // Send Commands - These are typically one-shot type and should reset after 1x scan time
  void sendCommand(int address, bool state) {
    var connectionMap = mbHandler.connectionMap;
    String ipAddress = gameDataHandler.getGame().ip;
    connectionMap[ipAddress]!.write(address, state);
    // Wait for a full scan rate - then invert
    Timer(Duration(milliseconds: mbHandler.pollRate), (){
      connectionMap[ipAddress]!.write(address, !state);
    });
  }

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