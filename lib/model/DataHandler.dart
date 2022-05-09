import 'package:flutter_windows/model/alert/AlertDataHandler.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/model/puzzle/PuzzleDataHandler.dart';
import 'package:flutter_windows/model/room/RoomDataHandler.dart';

import 'action/ActionDataHandler.dart';

class DataHandler{
  final ActionDataHandler actionDataHandler;
  final AlertDataHandler alertDataHandler;
  final EquipmentDataHandler equipmentDataHandler;
  final PuzzleDataHandler puzzleDataHandler;
  final RoomDataHandler roomDataHandler;

  final String roomID;

  DataHandler({required this.roomID, required this.actionDataHandler, required this.alertDataHandler, required this.equipmentDataHandler, required this.puzzleDataHandler, required this.roomDataHandler});
}