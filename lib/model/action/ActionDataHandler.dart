import 'package:flutter_windows/controller/DataFactory.dart';

import 'ActionData.dart';

class ActionDataHandler{
  ActionData createAction(String time, String description, String reference, ActionType actionType){
    // Validate Time
    if(time.contains(":") == false) print("Invalid Time"); // TODO: Throw Exception

    return ActionData(time: time, description: description, reference: reference, type: actionType);
  }
}