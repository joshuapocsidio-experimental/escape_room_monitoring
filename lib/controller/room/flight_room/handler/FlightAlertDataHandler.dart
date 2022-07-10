import 'package:flutter_windows/model/alert/AlertData.dart';

import '../../../../model/alert/AlertDataHandler.dart';

class FlightAlertDataHandler extends AlertDataHandler{
  // Data Flags
  late bool changeDetected;
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

  late bool FLRM01_AlertAck_S;

  @override
  void readData(List<bool> digitalInputs, List<int> analogInputs) {
    // Flag Reset
    changeDetected = false;

    // Stage Alarms
    FLRM01_Stage01Flt_A = digitalInputs[450]; // NOT USED
    FLRM01_Stage02Flt_A = digitalInputs[451]; // NOT USED
    FLRM01_Stage03Flt_A = digitalInputs[452]; // NOT USED
    FLRM01_Stage04Flt_A = digitalInputs[453]; // NOT USED
    FLRM01_Stage05Flt_A = digitalInputs[454]; // NOT USED
    FLRM01_Stage06Flt_A = digitalInputs[455]; // Keypad Stage
    FLRM01_Stage07Flt_A = digitalInputs[456]; // NOT USED
    FLRM01_Stage08Flt_A = digitalInputs[457]; // PC Login Stage
    FLRM01_Stage09Flt_A = digitalInputs[458]; // Test Tube Table Stage
    FLRM01_Stage10Flt_A = digitalInputs[459]; // NOT USED
    FLRM01_Stage11Flt_A = digitalInputs[460]; // Emergency Stage
    FLRM01_AlertAck_S = digitalInputs[218]; // Alert Acknowledge
    _processAlertState(id: '20', activeState: FLRM01_Stage06Flt_A);
    _processAlertState(id: '21', activeState: FLRM01_Stage08Flt_A);
    _processAlertState(id: '22', activeState: FLRM01_Stage09Flt_A);
    _processAlertState(id: '23', activeState: FLRM01_Stage11Flt_A);

    // Check for global acknowledge
    super.acknowledgeFeedback = FLRM01_AlertAck_S;
    // Only update GUI if any data change detected
    if(changeDetected == true) {
      super.notifyCallbacks();
    }
    changeDetected = false;
  }

  void _processAlertState({required String id, required bool activeState}){
    bool alertExists = doesActiveAlertEntryExist(id);

    // If alert doesn't exist, simply add to the list
    if(alertExists == false && activeState == true) {
      AlertData newAlert = super.alertReferenceMap[id]!.clone();
      newAlert.active = activeState;

      if (activeState == true) {
        if (super.addActiveAlert(id) == true) {
          changeDetected = true;
        }
      }
      return;
    }

    // If alert exists and active state is true, check for changes
    if(alertExists == true){
      AlertData existingAlert = super.activeAlertMap[id]!;
      // Detect any changes in state and modify existing alert
      if(activeState != existingAlert.active) {
        super.updateAlertState(id, activeState);
        changeDetected = true;
      }
      // If existing alert is inactive, add to the list
      if(existingAlert.active == false) {
        AlertData newAlert = super.alertReferenceMap[id]!.clone();
        newAlert.updateState(activeState);

        if(super.addActiveAlert(id) == true) {
          changeDetected = true;
        }
      }
    }
  }

}