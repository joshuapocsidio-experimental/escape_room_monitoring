import 'package:flutter_windows/model/alert/AlertData.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/plc/PLCTagData.dart';

class InfoAlert extends AlertData{
  InfoAlert({required String id, required String title, required String description, required String reference, required bool active,
    required PLCTagData plcTagData,
    required String recommendedAction,
  }) :
      super(
        id: title,
        title: title,
        description: description,
        reference: reference,
        alertText: "4 - Info",
        activeColor: Colors.blue,
        active: active,
        plcTagData: plcTagData,
        recommendedAction: recommendedAction,
      );
  @override
  InfoAlert clone([bool isActive = false]) {
    return InfoAlert(
      id: id,
      reference: reference,
      description: description,
      title: title,
      active: isActive,
      plcTagData: plcTagData,
      recommendedAction: recommendedAction,
    );
  }
}