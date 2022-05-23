import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';

class FlightRoomEquipmentDataHandler extends EquipmentDataHandler{
  late bool changesMade;

  // Power Supply
  late bool FLRM01_12VRly_Cls_I, FLRM01_24VRly_Cls_I;
  // Electromagnet Door Locks
  late bool FLRM01_DL001_O, FLRM01_DL002_O, FLRM01_DL003_O, FLRM01_DL004_O, FLRM01_DL005_O;
  // Door Sensors
  late bool FLRM01_DS001_Cls_I, FLRM01_DS002_Cls_I, FLRM01_DS003_Cls_I, FLRM01_DS004_Cls_I, FLRM01_DS005_Cls_I;
  // Test TUbe Table - Linear Actuator
  late bool FLRM01_LA001_O;
  // Test Tube Table - Limit Switches
  late bool FLRM01_LS001_Act_I, FLRM01_LS002_Act_I;
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
  void updateData(List<bool> data) {
    changesMade = false;
    // A - Introduction Push Button (no fault state)
    FLRM01_PB001_On_I = data[129];
    _processDataState(id: 'A', state: FLRM01_PB001_On_I);
    // B - Multi Notch Controller (no fault state)
    FLRM01_MX001_Act_I = data[132];
    _processDataState(id: 'B', state: FLRM01_MX001_Act_I);
    // C - Multiple Rotary Switches
    FLRM01_SW001_On_I = data[130];
    _processDataState(id: 'C', state: FLRM01_SW001_On_I);
    // D - Keypad Door Lock (fault state with Keypad Door Sensor)
    FLRM01_DL001_O = data[0];
    _processDataState(id: 'D', state: FLRM01_DL001_O);
    _processDataFault(id: 'D', faultState: FLRM01_DL001_O);
    // E - Keypad Door Sensor (fault state with Keypad Door Lock)
    FLRM01_DS001_Cls_I = data[120];
    _processDataState(id: 'E', state: FLRM01_DS001_Cls_I);
    _processDataFault(id: 'E', faultState: FLRM01_DS001_Cls_I);
    // F - Overhead Cabinet Door Lock (fault state with Overhead Cabinet Door Sensor)
    FLRM01_DL002_O = data[1];
    _processDataState(id: 'F', state: FLRM01_DL002_O);
    _processDataFault(id: 'F', faultState: FLRM01_DL002_O);
    // G - Overhead Cabinet Sensor (fault state with Overhead Cabinet Door Lock)
    FLRM01_DS002_Cls_I = data[121];
    _processDataState(id: 'G', state: FLRM01_DS002_Cls_I);
    _processDataFault(id: 'G', faultState: FLRM01_DS002_Cls_I);
    // H - Test Tube Switch (no fault state)
    FLRM01_SW002_On_I = data[131];
    _processDataState(id: 'H', state: FLRM01_SW002_On_I);
    _processDataFault(id: 'H', faultState: FLRM01_SW002_On_I);
    // I - Test Tube Table - Linear Actuator (no fault state)
    FLRM01_LA001_O = data[5];
    _processDataState(id: 'I', state: FLRM01_LA001_O);
    _processDataFault(id: 'I', faultState: FLRM01_LA001_O);
    // J - Test Tube Table - Indicator Limit Switch (fault state with End of Travel Limit Switch)
    FLRM01_LS001_Act_I = data[126];
    _processDataState(id: 'J', state: FLRM01_LS001_Act_I);
    _processDataFault(id: 'J', faultState: FLRM01_LS001_Act_I);
    // K - Test Tube Table - End of Travel Limit Switch (fault state with Indicator Limit Switch)
    FLRM01_LS002_Act_I = data[127];
    _processDataState(id: 'K', state: FLRM01_LS002_Act_I);
    // L - Antidote Panel Door Lock (fault state with Antidote Panel Door Sensor)
    FLRM01_DL003_O = data[2];
    _processDataState(id: 'L', state: FLRM01_DL003_O);
    _processDataFault(id: 'L', faultState: FLRM01_DL003_O);
    // M - Antidote Panel Door Sensor (fault state with door sensor)
    FLRM01_DS003_Cls_I = data[122];
    _processDataState(id: 'M', state: FLRM01_DS003_Cls_I);
    _processDataFault(id: 'M', faultState: FLRM01_DS003_Cls_I);
    // N - Lever Panel Door Lock (fault state with Lever Panel Door Sensor)
    FLRM01_DL004_O = data[3];
    _processDataState(id: 'N', state: FLRM01_DL004_O);
    _processDataFault(id: 'N', faultState: FLRM01_DL004_O);
    // O - Lever Panel Door Sensor (fault state with door sensor)
    FLRM01_DS004_Cls_I = data[123];
    _processDataState(id: 'O', state: FLRM01_DS004_Cls_I);
    _processDataFault(id: 'O', faultState: FLRM01_DS004_Cls_I);
    // P - Cockpit Lever (no fault state)
    FLRM01_LV001_Act_I = data[128];
    _processDataState(id: 'P', state: FLRM01_LV001_Act_I);
    // Q - Emergency Lighting (no fault state)
    FLRM01_LT001_O = data[6];
    _processDataState(id: 'Q', state: FLRM01_LT001_O);
    // R - Exit Door Lock (fault state with Exit Door Sensor)
    FLRM01_DL005_O = data[4];
    _processDataState(id: 'R', state: FLRM01_DL005_O);
    _processDataFault(id: 'R', faultState: FLRM01_DL005_O);
    // S - Exit Door Sensor (fault state with electromagnet)
    FLRM01_DS005_Cls_I = data[124];
    _processDataState(id: 'S', state: FLRM01_DS005_Cls_I);
    _processDataFault(id: 'S', faultState: FLRM01_DS005_Cls_I);


    // Only update GUI if any data change detected
    if(changesMade == true) {
      super.notifyCallbacks();
    }
    super.updateData(data);
    changesMade = false;
  }

  void _processDataState({required String id, required bool state}){
    if(super.equipmentDataMap[id]!.state != state){
      super.equipmentDataMap[id]!.updateState(state);
      changesMade = true;
    }
  }

  void _processDataFault({required String id, required bool faultState}){
    if(super.equipmentDataMap[id]!.faulted != faultState){
      super.equipmentDataMap[id]!.updateFaulted(faultState);
      changesMade = true;
    }
  }
}