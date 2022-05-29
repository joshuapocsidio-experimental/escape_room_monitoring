import 'package:flutter_windows/model/alert/AlertData.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AlarmAlert extends AlertData{
  AlarmAlert({required String id, required String title, required String description, required String reference, required bool active}) :
      super(
        id: id,
        title: title,
        description: description,
        reference: reference,
        alertText: "1 - Alarm",
        activeColor: Colors.red,
        active: active,
  );

  @override
  AlarmAlert clone([bool isActive = false]) {
    return AlarmAlert(
      id: id,
      reference: reference,
      description: description,
      title: title,
      active: isActive,
    );

  }
}