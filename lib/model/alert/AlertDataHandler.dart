import 'package:flutter_windows/model/DataObserver.dart';
import 'package:flutter_windows/model/alert/AttentionAlert.dart';
import 'package:flutter_windows/model/alert/InfoAlert.dart';
import 'package:flutter_windows/model/alert/InvalidAlertTypeException.dart';
import 'package:flutter_windows/model/plc/PLCTagData.dart';

import 'AlarmAlert.dart';
import 'AlertData.dart';
import 'WarningAlert.dart';

class AlertDataHandler extends DataObserver{
  // Data Source
  late final AlertDataSource alertDataSource;

  // Reference alerts
  final List<AlertData> alertReferenceList = [];
  final Map<String, AlertData> alertReferenceMap = {};
  // Active alerts
  final List<AlertData> activeAlertList = [];
  final Map<String, AlertData> activeAlertMap = {};
  // Acknowledged alerts
  final List<AlertData> acknowledgedAlertList = [];
  // Alert History
  final List<AlertData> historyAlertList = [];

  final List<Function> callbacks = [];

  void updateAlertState(String id, bool activeState, bool acknowledgeState) {
    if(activeAlertMap.containsKey(id) == false) {
      return;
    }
    // Update Map
    AlertData activeAlert = activeAlertMap[id]!;
    activeAlert.updateState(activeState, acknowledgeState);
    // Update List
    for(AlertData alert in activeAlertList) {
      if(alert.id == id) {
        alert.updateState(activeState, acknowledgeState);
        return;
      }
    }
  }

  void updateTableMode(int mode) {
    switch(mode) {
      case 0:
        alertDataSource.updateGridSource(historyAlertList);
        break;
      case 1:
        alertDataSource.updateGridSource(activeAlertList);
        break;
      case 2:
        alertDataSource.updateGridSource(acknowledgedAlertList);
        break;
    }
  }

  bool doesActiveAlertEntryExist(String id) {
    return activeAlertMap.containsKey(id);
  }

  void performAcknowledgeCheck(String id) {
    if(activeAlertMap.containsKey(id) == false) {
      return;
    }
    AlertData alert = activeAlertMap[id]!;
    bool activeState = alert.active;
    bool acknowledgeState = alert.acknowledge;
    // 0 0 - Inactive State and Not Acknowledged  == Do nothing
    if(activeState == false && acknowledgeState == false) {}
    // 0 1 - Inactive State and Acknowledged      == Remove from active alerts list/map | Add to acknowledge alerts list/map
    if(activeState == false && acknowledgeState == true) {
      removeActiveAlert(alert);
      addAcknowledgedAlert(alert);
    }
    // 1 0 - Active State and Not Acknowledged    == Do nothing
    if(activeState == true && acknowledgeState == false) {}
    // 1 1 - Active State and Acknowledged        == Keep as active alerts list/map | Add to acknowledge alerts list/map
    if(activeState == true && acknowledgeState == true) {
      addAcknowledgedAlert(alert);
    }
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
    addHistoryAlert(newAlert);
    return true;
  }

  bool removeActiveAlert(AlertData oldAlert) {
    if(doesActiveAlertEntryExist(oldAlert.id)){
      activeAlertList.remove(oldAlert);
      activeAlertMap.remove(oldAlert.id);
      return true;
    }
    return false;
  }
//
//  bool acknowledgeActiveAlert(String id) {
//    if(activeAlertMap.containsKey(id) == true){
//      activeAlertMap[id]!.acknowledge = true;
//      for(AlertData alert in activeAlertList){
//        if(alert.id == id){
//          alert.acknowledge = true;
//          // Add to acknowledged alert list
//          addAcknowledgedAlert(alert.clone(alert.active));
//          // Remove from active alert list - only if it is inactive
//          if(alert.active == false){
//            removeActiveAlert(alert);
//          }
//          return true;
//        }
//      }
//    }
//    return false;
//  }

  /// ACKNOWLEDGED ALERT HANDLING
  void addAcknowledgedAlert(AlertData ackAlert) {
    if(acknowledgedAlertList.contains(ackAlert) == true){
      return;
    }
    acknowledgedAlertList.add(ackAlert);
  }

  bool removeAcknowledgedAlert(AlertData alert) {
    for(int i = 0; i < acknowledgedAlertList.length; i++){
      AlertData alertData = acknowledgedAlertList[i];
      if(alertData.id == alert.id && alertData.timeString == alert.timeString) {
        acknowledgedAlertList.remove(alertData);
        return true;
      }
    }
    return false;
  }

  /// ALL ALERT HANDLING
  bool addHistoryAlert(AlertData newAlert) {
    historyAlertList.add(newAlert);
    return true;
  }

  bool removeHistoryAlert(AlertData alert) {
    for(int i = 0; i < historyAlertList.length; i++) {
      AlertData existingAlert = historyAlertList[i];
      if(existingAlert.id == alert.id && existingAlert.timeString == alert.timeString) {
        historyAlertList.remove(alert);
        return true;
      }
    }
    return false;
  }

  /// OBSERVER HANDLING
  void addCallback(Function callback){
    if(callbacks.contains(callback) == false){
      this.callbacks.add(callback);
    }
  }

  void notifyCallbacks(){
    for(Function callback in callbacks){
      callback();
    }
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

  void processAlertState({required String id, required bool activeState, required bool acknowledgeState}) {

  }

  @override
  void updateData(List<bool> data) {
//    print("Alert Data - Update Data callback");
    super.updateData(data);
  }

  void acknowledge(){
    
  }
}

