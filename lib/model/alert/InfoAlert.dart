import 'package:flutter_windows/model/alert/AlertData.dart';
import 'package:fluent_ui/fluent_ui.dart';

class InfoAlert extends AlertData{
  InfoAlert({required String id, required String title, required String description, required String reference, required bool active}) :
      super(
        id: title,
        title: title,
        description: description,
        reference: reference,
        alertText: "4 - Info",
        activeColor: Colors.blue,
        active: active,
      );
  @override
  InfoAlert clone([bool isActive = false]) {
    return InfoAlert(
      id: id,
      reference: reference,
      description: description,
      title: title,
      active: isActive,
    );
  }
}