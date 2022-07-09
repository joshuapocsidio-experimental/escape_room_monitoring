import '../DataNotifier.dart';
import 'ActionData.dart';

class ActionDataHandler extends DataNotifier{
  ActionData createAction(String time, String description, String reference, ActionType actionType){
    // Validate Time
    if(time.contains(":") == false) print("Invalid Time"); // TODO: Throw Exception

    return ActionData(time: time, description: description, reference: reference, type: actionType);
  }
}