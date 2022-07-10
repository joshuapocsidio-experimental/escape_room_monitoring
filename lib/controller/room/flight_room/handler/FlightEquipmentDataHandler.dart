import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';

class FlightRoomEquipmentDataHandler extends EquipmentDataHandler{
  late bool equipmentStateChanged, equipmentFaultChanged;
  late bool changeDetected;

  // Power Supply
  late bool FLRM01_12VRly_Cls_I, FLRM01_24VRly_Cls_I;
  // Electromagnet Door Locks
  late bool FLRM01_DL001_O, FLRM01_DL002_O, FLRM01_DL003_O, FLRM01_DL004_O, FLRM01_DL005_O;
  late bool FLRM01_DL001_Flt_A, FLRM01_DL002_Flt_A, FLRM01_DL003_Flt_A, FLRM01_DL004_Flt_A, FLRM01_DL005_Flt_A;
  // Door Sensors
  late bool FLRM01_DS001_Cls_I, FLRM01_DS002_Cls_I, FLRM01_DS003_Cls_I, FLRM01_DS004_Cls_I, FLRM01_DS005_Cls_I;
  late bool FLRM01_DS001_Flt_A, FLRM01_DS002_Flt_A, FLRM01_DS003_Flt_A, FLRM01_DS004_Flt_A, FLRM01_DS005_Flt_A;
  // Test TUbe Table - Linear Actuator
  late bool FLRM01_LA001_O;
  // Test Tube Table - Limit Switches
  late bool FLRM01_LS001_Act_I, FLRM01_LS002_Act_I;
  late bool FLRM01_LS001_Flt_A, FLRM01_LS002_Flt_A;
  // Emergency Lighting
  late bool FLRM01_LT001_O;
  // Cockpit Lever
  late bool FLRM01_LV001_Act_I;
  // Intro Push button
  late bool FLRM01_PB001_On_I;
  // Multi Rotary Switches
  late bool FLRM01_SW001_On_I;
  // Test Tube Table - Hydraulic Switch
  late bool FLRM01_SW002_On_I;
  // Multi Notch Controller
  late bool FLRM01_MX001_Act_I;

  @override
  void readData(List<bool> digitalInputs, List<int> analogInputs) {
    // Reset Flags
    equipmentFaultChanged = false;
    equipmentStateChanged = false;
    changeDetected = false;

    // A - Introduction Push Button (no fault state)
    FLRM01_PB001_On_I = digitalInputs[129];
    _processDataState(id: 'PB001', state: FLRM01_PB001_On_I);
    // B - Multi Notch Controller (no fault state)
    FLRM01_MX001_Act_I = digitalInputs[132];
    _processDataState(id: 'MX001', state: FLRM01_MX001_Act_I);
    // C - Multiple Rotary Switches
    FLRM01_SW001_On_I = digitalInputs[130];
    _processDataState(id: 'SW001', state: FLRM01_SW001_On_I);
    // D - Keypad Door Lock (fault state with Keypad Door Sensor)
    FLRM01_DL001_O = digitalInputs[0];
    FLRM01_DL001_Flt_A = digitalInputs[415];
    _processDataState(id: 'DL001', state: FLRM01_DL001_O);
    _processDataFault(id: 'DL001', faultState: FLRM01_DL001_Flt_A);
    // E - Keypad Door Sensor (fault state with Keypad Door Lock)
    FLRM01_DS001_Cls_I = digitalInputs[120];
    FLRM01_DS001_Flt_A = digitalInputs[410];
    _processDataState(id: 'DS001', state: FLRM01_DS001_Cls_I);
    _processDataFault(id: 'DS001', faultState: FLRM01_DS001_Flt_A);
    // F - Overhead Cabinet Door Lock (fault state with Overhead Cabinet Door Sensor)
    FLRM01_DL002_O = digitalInputs[1];
    FLRM01_DL002_Flt_A = digitalInputs[416];
    _processDataState(id: 'DL002', state: FLRM01_DL002_O);
    _processDataFault(id: 'DL002', faultState: FLRM01_DL002_Flt_A);
    // G - Overhead Cabinet Sensor (fault state with Overhead Cabinet Door Lock)
    FLRM01_DS002_Cls_I = digitalInputs[121];
    FLRM01_DS002_Flt_A = digitalInputs[411];
    _processDataState(id: 'DS002', state: FLRM01_DS002_Cls_I);
    _processDataFault(id: 'DS002', faultState: FLRM01_DS002_Flt_A);
    // H - Test Tube Switch (no fault state)
    FLRM01_SW002_On_I = digitalInputs[131];
    _processDataState(id: 'SW002', state: FLRM01_SW002_On_I);
    // I - Test Tube Table - Linear Actuator (no fault state)
    FLRM01_LA001_O = digitalInputs[5];
    _processDataState(id: 'LA001', state: FLRM01_LA001_O);
    // J - Test Tube Table - Indicator Limit Switch (fault state with End of Travel Limit Switch)
    FLRM01_LS001_Act_I = digitalInputs[126];
    FLRM01_LS001_Flt_A = digitalInputs[420];
    _processDataState(id: 'LS001', state: FLRM01_LS001_Act_I);
    _processDataFault(id: 'LS001', faultState: FLRM01_LS001_Flt_A);
    // K - Test Tube Table - End of Travel Limit Switch (fault state with Indicator Limit Switch)
    FLRM01_LS002_Act_I = digitalInputs[127];
    FLRM01_LS002_Flt_A = digitalInputs[421];
    _processDataState(id: 'LS002', state: FLRM01_LS002_Act_I);
    _processDataFault(id: 'LS002', faultState: FLRM01_LS002_Flt_A);
    // L - Antidote Panel Door Lock (fault state with Antidote Panel Door Sensor)
    FLRM01_DL003_O = digitalInputs[2];
    FLRM01_DL003_Flt_A = digitalInputs[412];
    _processDataState(id: 'DL003', state: FLRM01_DL003_O);
    _processDataFault(id: 'DL003', faultState: FLRM01_DL003_Flt_A);
    // M - Antidote Panel Door Sensor (fault state with door sensor)
    FLRM01_DS003_Cls_I = digitalInputs[122];
    FLRM01_DS003_Flt_A = digitalInputs[417];
    _processDataState(id: 'DS003', state: FLRM01_DS003_Cls_I);
    _processDataFault(id: 'DS003', faultState: FLRM01_DS003_Flt_A);
    // N - Lever Panel Door Lock (fault state with Lever Panel Door Sensor)
    FLRM01_DL004_O = digitalInputs[3];
    FLRM01_DL004_Flt_A = digitalInputs[418];
    _processDataState(id: 'DL004', state: FLRM01_DL004_O);
    _processDataFault(id: 'DL004', faultState: FLRM01_DL004_Flt_A);
    // O - Lever Panel Door Sensor (fault state with door sensor)
    FLRM01_DS004_Cls_I = digitalInputs[123];
    FLRM01_DS004_Flt_A = digitalInputs[413];
    _processDataState(id: 'DS004', state: FLRM01_DS004_Cls_I);
    _processDataFault(id: 'DS004', faultState: FLRM01_DS004_Flt_A);
    // P - Cockpit Lever (no fault state)
    FLRM01_LV001_Act_I = digitalInputs[128];
    _processDataState(id: 'LV001', state: FLRM01_LV001_Act_I);
    // Q - Emergency Lighting (no fault state)
    FLRM01_LT001_O = digitalInputs[6];
    _processDataState(id: 'LT001', state: FLRM01_LT001_O);
    // R - Exit Door Lock (fault state with Exit Door Sensor)
    FLRM01_DL005_O = digitalInputs[4];
    FLRM01_DL005_Flt_A = digitalInputs[419];
    _processDataState(id: 'DL005', state: FLRM01_DL005_O);
    _processDataFault(id: 'DL005', faultState: FLRM01_DL005_Flt_A);
    // S - Exit Door Sensor (fault state with electromagnet)
    FLRM01_DS005_Cls_I = digitalInputs[124];
    FLRM01_DS005_Flt_A = digitalInputs[414];
    _processDataState(id: 'DS005', state: FLRM01_DS005_Cls_I);
    _processDataFault(id: 'DS005', faultState: FLRM01_DS005_Flt_A);

    // Only update GUI if any data change detected
    changeDetected = equipmentStateChanged || equipmentFaultChanged;
    if(changeDetected == true) {
      super.notifyCallbacks();
    }
  }

  void _processDataState({required String id, required bool state}){
    if(super.equipmentDataMap[id]!.state != state){
      super.equipmentDataMap[id]!.updateState(state);
      equipmentStateChanged = true;
    }
  }

  void _processDataFault({required String id, required bool faultState}){
    if(super.equipmentDataMap[id]!.faulted != faultState){
      super.equipmentDataMap[id]!.updateFaulted(faultState);
      equipmentFaultChanged = true;
    }
  }
}