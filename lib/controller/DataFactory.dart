import 'package:flutter_windows/model/room/GameData.dart';

import '../model/action/ActionData.dart';

class DataFactory{
  /// CONCURRENT
  static ActionData createAction(String time, String description, String reference, ActionType actionType){
    // Validate Time
    if(time.contains(":") == false) print("Invalid Time"); // TODO: Throw Exception

    return ActionData(time: time, description: description, reference: reference, type: actionType);
  }

  /// INITIAL
  static GameData createRoom(String ip, String id, String maxTime, String name){
    // Validate Time
    if(maxTime.contains(":") == false) print("Invalid Time"); // TODO: Throw Exception

    return GameData(ip: ip, id: id, maxTime: maxTime, name: name);
  }
  
  
}