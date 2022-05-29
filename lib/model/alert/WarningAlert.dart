import 'package:flutter_windows/model/alert/AlertData.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WarningAlert extends AlertData{
  WarningAlert({required String id, required String title, required String description, required String reference, required bool active}) :
      super(
        id: title,
        title: title,
        description: description,
        reference: reference,
        alertText: "3 - Warning",
        activeColor: Colors.orange,
        active: active,
      );
  @override
  WarningAlert clone([bool isActive = false]) {
    return WarningAlert(
      id: id,
      reference: reference,
      description: description,
      title: title,
      active: isActive,
    );
  }
}