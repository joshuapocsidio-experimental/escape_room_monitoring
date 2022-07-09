import 'package:flutter_windows/model/DataNotifier.dart';
import 'package:flutter_windows/model/alert/AttentionAlert.dart';
import 'package:flutter_windows/model/alert/InfoAlert.dart';
import 'package:flutter_windows/model/alert/InvalidAlertTypeException.dart';
import 'package:flutter_windows/model/plc/PLCTagData.dart';

import 'AlarmAlert.dart';
import 'AlertData.dart';
import 'WarningAlert.dart';

abstract class AlertDataHandler extends DataNotifier{
  // Update Data
  void readData(List<bool> digitalInputs, List<int> analogInputs);
  // Data Source
  late final AlertDataSource alertDataSource;

  // Reference alerts
  final List<AlertData> alertReferenceList = [];
  final Map<String, AlertData> alertReferenceMap = {};
  // Active alerts
  final List<AlertData> activeAlertList = [];
  final Map<String, AlertData> activeAlertMap = {};
  int tableMode = 0;

  bool acknowledgeFeedback = false;

  void updateAlertState(String id, bool activeState) {
    bool acknowledge = true;
    if(activeAlertMap.containsKey(id) == false) {
      return;
    }
    if(activeState == true) {
      acknowledge = false;
    }
    // Update Map
    AlertData activeAlert = activeAlertMap[id]!;
    activeAlert.updateState(activeState);
    activeAlert.updateAcknowledge(acknowledge);
    // Update List
    for(AlertData alert in activeAlertList) {
      if(alert.id == id) {
        alert.updateState(activeState);
        activeAlert.updateAcknowledge(acknowledge);
      }
    }
  }

  void acknowledgeAll() {
    for(AlertData alert in activeAlertMap.values) {
      alert.updateAcknowledge(true);
    }
    for(AlertData alert in activeAlertList) {
      alert.updateAcknowledge(true);
    }
    notifyCallbacks();
  }

  void updateTableMode(int mode) {
    tableMode = mode;
  }

  void updateTable() {
    alertDataSource.updateGridSource(activeAlertList);
  }

  bool doesActiveAlertEntryExist(String id) {
    return activeAlertMap.containsKey(id);
  }

  /// ACTIVE ALERT HANDLING
  bool addActiveAlert(String id) {
    if(doesActiveAlertEntryExist(id) == true){
      return false;
    }
    DateTime dt = DateTime.now();
    AlertData newAlert = alertReferenceMap[id]!.clone();
    newAlert.active = true;
    newAlert.dateTime = dt;
    newAlert.timeString = "${dt.hour..toString().padLeft(2,"0")}"
        ":${dt.minute.toString().padLeft(2,"0")}"
        ":${dt.second.toString().padLeft(2,"0")}";

    // if alert doesn't already exist - push into the table
    activeAlertList.add(newAlert);
    activeAlertMap[newAlert.id] = newAlert;
    return true;
  }

  void addAlertReference(List<List<String>> alertStringList){
      String alertID, alertName, alertDesc, alertRef, alertType;
      String plcTag, plcType, plcAddress, plcDescription;
      String recommendedAction;

      for(int i = 0; i <alertStringList.length; i++) {
        List<String> alertString = alertStringList[i];

        alertID = alertString[0];
        alertType = alertString[1];
        alertName = alertString[2];
        alertDesc = alertString[3];
        alertRef = alertString[4];

        plcTag = alertString[5];
        plcType = alertString[6];
        plcAddress = alertString[7];
        plcDescription = alertString[8];
        PLCTagData plcTagData = PLCTagData(tag: plcTag, dataType: plcType, tagAddress: plcAddress, description: plcDescription);

        recommendedAction = alertString[9];

        try{
          AlertData newAlert = createAlert(alertID, alertType, alertName, alertDesc, alertRef, plcTagData, recommendedAction);
          alertReferenceMap[alertID] = newAlert;
          alertReferenceList.add(newAlert);
        }
        on InvalidAlertTypeException catch(e) {
          print("Debug: ${e.message}");
        }
      }
  }

  /// INITIAL
  AlertData createAlert(String id, String type, String name, String description, String ref, PLCTagData plcTagData, String recommendedAction){
    switch(type.toLowerCase()){
      case 'alm':
        return AlarmAlert(id: id, reference: ref, description: description, title: name, active: false, plcTagData: plcTagData, recommendedAction: recommendedAction);
      case 'att':
        return AttentionAlert(id: id, reference: ref, description: description, title: name, active: false, plcTagData: plcTagData, recommendedAction: recommendedAction);
      case 'wrn':
        return WarningAlert(id: id, reference: ref, description: description, title: name, active: false, plcTagData: plcTagData, recommendedAction: recommendedAction);
      case 'inf':
        return InfoAlert(id: id, reference: ref, description: description, title: name, active: false, plcTagData: plcTagData, recommendedAction: recommendedAction);
      default:
        throw InvalidAlertTypeException(message: "InvalidAlertTypeException : Attempted to create an alert with unknown alert type = $id");
    }
  }
}

