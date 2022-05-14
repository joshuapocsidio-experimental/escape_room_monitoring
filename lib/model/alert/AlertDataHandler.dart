import 'package:flutter_windows/model/DataObserver.dart';

import 'AlertData.dart';

class AlertDataHandler extends DataObserver{
  /// CONCURRENT
  static AlertData createAlert(String time, String title, String description, String reference, AlertType alertType){
    // Validate Time
    if(time.contains(":") == false) print("Invalid Time"); // TODO: Throw Exception

    return AlertData(time: time, title: title, description: description, type: alertType, reference: reference);
  }

  @override
  void updateData(List<bool> data) {
    print("Alert Data - Update Data callback");
    super.updateData(data);
  }
}