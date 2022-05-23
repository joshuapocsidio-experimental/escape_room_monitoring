import 'package:flutter_windows/model/equipment/EquipmentData.dart';
import 'package:flutter_windows/model/room/RoomData.dart';

import '../model/action/ActionData.dart';
import '../model/alert/AlertData.dart';
import '../model/puzzle/PuzzleData.dart';

class DataFactory{
  /// CONCURRENT
  static ActionData createAction(String time, String description, String reference, ActionType actionType){
    // Validate Time
    if(time.contains(":") == false) print("Invalid Time"); // TODO: Throw Exception

    return ActionData(time: time, description: description, reference: reference, type: actionType);
  }

  /// CONCURRENT
  static AlertData createAlert(String time, String title, String description, String reference, AlertType alertType){
    // Validate Time
    if(time.contains(":") == false) print("Invalid Time"); // TODO: Throw Exception

    return AlertData(time: time, title: title, description: description, type: alertType, reference: reference);
  }

  /// INITIAL
  // static EquipmentData createEquipment(String equipReference, String reference, String name, String description, String onText, String offText, int state){
  //   EquipmentState equipmentState;
  //   if(state == -1) equipmentState = EquipmentState.FAULT;
  //   else if(state == 0) equipmentState = EquipmentState.OFF;
  //   else if(state == 1) equipmentState = EquipmentState.ON;
  //   else {
  //     equipmentState = EquipmentState.FAULT;
  //     print("Invalid Equipment Data");
  //     // TODO: Throw Exception
  //   }
  //
  //   return EquipmentData(equipReference: equipReference, reference: reference, offText: offText, description: description, name: name, state: equipmentState, onText: onText);
  // }

//  /// INITIAL
//  static PuzzleData createPuzzle(String reference, String description, String name, int state){
//    PuzzleState puzzleState;
//
//    if(state == -1) puzzleState = PuzzleState.NotMonitored;
//    else if(state == 0) puzzleState = PuzzleState.NotAttempted;
//    else if(state == 1) puzzleState = PuzzleState.InProgress;
//    else if(state == 2) puzzleState = PuzzleState.Attempted;
//    else if(state == 3) puzzleState = PuzzleState.Bypassed;
//    else if(state == 4) puzzleState = PuzzleState.Completed;
//    else{
//      puzzleState = PuzzleState.NotMonitored;
//      print("Invalid Puzzle Data");
//      // TODO: Throw Exception
//    }
//    return PuzzleData(reference: reference, description: description, name: name, state: puzzleState);
//  }

  /// INITIAL
  static RoomData createRoom(String ip, String id, String maxTime, String name){
    // Validate Time
    if(maxTime.contains(":") == false) print("Invalid Time"); // TODO: Throw Exception

    return RoomData(ip: ip, id: id, maxTime: maxTime, name: name);
  }
  
  
}