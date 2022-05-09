import 'AlertData.dart';

class AlertDataHandler{
  /// CONCURRENT
  static AlertData createAlert(String time, String title, String description, String reference, AlertType alertType){
    // Validate Time
    if(time.contains(":") == false) print("Invalid Time"); // TODO: Throw Exception

    return AlertData(time: time, title: title, description: description, type: alertType, reference: reference);
  }
}