import 'package:flutter_windows/model/alert/AlertData.dart';

import '../../../model/alert/AlertDataHandler.dart';

class FlightRoomAlertDataHandler extends AlertDataHandler{
  late bool changesMade;

  // Power Supply Alerts
  late bool FLRM01_12VRly_Flt_A, FLRM01_24VRly_Flt_A;
  // Communications Alerts
  late bool FLRM01_RPI00_ComFlt_A, FLRM01_RPI01_ComFlt_A, FLRM01_RPI02_ComFlt_A;
  // Equipment Alerts
  late bool FLRM01_DL001_EqpFlt_A, FLRM01_DS001_EqpFlt_A;
  late bool FLRM01_DL002_EqpFlt_A, FLRM01_DS002_EqpFlt_A;
  late bool FLRM01_DL003_EqpFlt_A, FLRM01_DS003_EqpFlt_A;
  late bool FLRM01_DL004_EqpFlt_A, FLRM01_DS004_EqpFlt_A;
  late bool FLRM01_DL005_EqpFlt_A, FLRM01_DS005_EqpFlt_A;
  late bool FLRM01_LS001_EqpFlt_A, FLRM01_LS002_EqpFlt_A;
  // Stage Alerts
  late bool FLRM01_Stage01Flt_A;
  late bool FLRM01_Stage02Flt_A;
  late bool FLRM01_Stage03Flt_A;
  late bool FLRM01_Stage04Flt_A;
  late bool FLRM01_Stage05Flt_A;
  late bool FLRM01_Stage06Flt_A;
  late bool FLRM01_Stage07Flt_A;
  late bool FLRM01_Stage08Flt_A;
  late bool FLRM01_Stage09Flt_A;
  late bool FLRM01_Stage10Flt_A;
  late bool FLRM01_Stage11Flt_A;
  // Alert Ack
  late bool FLRM01_AlertAck_S;

  @override
  void updateData(List<bool> data) {
    changesMade = false;
    // Stage Alarms
    FLRM01_Stage01Flt_A = data[450]; // NOT USED
    FLRM01_Stage02Flt_A = data[451]; // NOT USED
    FLRM01_Stage03Flt_A = data[452]; // NOT USED
    FLRM01_Stage04Flt_A = data[453]; // NOT USED
    FLRM01_Stage05Flt_A = data[454]; // NOT USED
    FLRM01_Stage06Flt_A = data[455]; // Keypad Stage
    FLRM01_Stage07Flt_A = data[456]; // NOT USED
    FLRM01_Stage08Flt_A = data[457]; // PC Login Stage
    FLRM01_Stage09Flt_A = data[458]; // Test Tube Table Stage
    FLRM01_Stage10Flt_A = data[459]; // NOT USED
    FLRM01_Stage11Flt_A = data[460]; // Emergency Stage
    FLRM01_AlertAck_S = data[215]; // Alert Acknowledge
    processAlertState(id: '20', activeState: FLRM01_Stage06Flt_A, acknowledgeState: FLRM01_AlertAck_S);
    processAlertState(id: '21', activeState: FLRM01_Stage08Flt_A, acknowledgeState: FLRM01_AlertAck_S);
    processAlertState(id: '22', activeState: FLRM01_Stage09Flt_A, acknowledgeState: FLRM01_AlertAck_S);
    processAlertState(id: '23', activeState: FLRM01_Stage11Flt_A, acknowledgeState: FLRM01_AlertAck_S);

    // Only update GUI if any data change detected
    if(changesMade == true) {
      super.notifyCallbacks();
    }
    super.updateData(data);
    changesMade = false;
  }

  @override
  void processAlertState({required String id, required bool activeState, required bool acknowledgeState}){
    bool alertExists = doesActiveAlertEntryExist(id);
    // Check if alert state doesn't exist in active alert list/map
    if(alertExists == false && activeState == true) {
      AlertData newAlert = super.alertReferenceMap[id]!.clone();
      newAlert.active = activeState;
      newAlert.acknowledge = acknowledgeState;

      if(super.addActiveAlert(id) == true) {
        print("CHECKPOINT A - SUCCESSFUL");
        changesMade = true;
        return;
      }
    }
    // Check if alert state already exists
    if(alertExists == true){
      AlertData existingAlert = super.activeAlertMap[id]!;
      // Check if active state change detected
      if(activeState != existingAlert.active){
        changesMade = true;
      }
      // Check if acknowledge state change detected
      if(acknowledgeState != existingAlert.acknowledge) {
        changesMade = true;
      }
      // If changes are made, call individual alert callbacks
      if(changesMade == true) {
        // Update Alert States
        super.updateAlertState(id, activeState, acknowledgeState);
        // Perform acknowledge checks
        super.performAcknowledgeCheck(id);
      }
    }


//    if(doesActiveAlertEntryExist(id) == true) {
//      print("CHECKPOINT Z");
//      if(super.activeAlertMap[id]!.active == true) {
//        // Check if alert state is transitioning from active to inactive state
//        if(activeState == false && acknowledgeState == true){
//          print("CHECKPOINT B");
//          if(super.acknowledgeActiveAlert(id) == true) {
//            changesMade = true;
//            print("CHECKPOINT B - SUCCESSFUL");
//            return;
//          }
//        }

//        // Check if alert state is active and acknowledge state is detected
//        if(acknowledgeState == true){
//          print("CHECKPOINT C");
//          if(super.acknowledgeActiveAlert(id) == true) {
//            changesMade = true;
//            print("CHECKPOINT C - SUCCESSFUL");
//            return;
//          }
//        }
//      }
  }

}