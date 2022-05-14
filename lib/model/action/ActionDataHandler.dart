import 'package:flutter_windows/controller/DataFactory.dart';

import '../DataObserver.dart';
import 'ActionData.dart';

class ActionDataHandler extends DataObserver{
  ActionData createAction(String time, String description, String reference, ActionType actionType){
    // Validate Time
    if(time.contains(":") == false) print("Invalid Time"); // TODO: Throw Exception

    return ActionData(time: time, description: description, reference: reference, type: actionType);
  }

  @override
  void updateData(List<bool> data) {
    print("Action Data - Update Data callback");
    super.updateData(data);
  }
}