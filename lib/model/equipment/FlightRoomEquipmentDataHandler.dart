import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';

class FlightRoomEquipmentDataHandler extends EquipmentDataHandler{
  late bool changesMade;

  @override
  void updateData(List<bool> data) {
    int length = data.length;
    changesMade = false;
    // Introduction Push button (no fault state)
    _processEquipment(0, data);
    // Multi-Notch Controller (no fault state)
    _processEquipment(1, data);
    // Rotary Switches (no fault state)
    _processEquipment(2, data);
    // Keypad Electromagnet (no fault state)
    _processEquipment(3, data);
    // Overhead Cabinet Electromagnet (fault state with door sensor)
    _processEquipment(4, data);
    _processEquipment(5, data);
    // Overhead Cabinet Door Sensor (fault state with electromagnet)
    _processEquipment(6, data);
    _processEquipment(7, data);
    // Test Tube Switch (no fault state)
    _processEquipment(8, data);
    // Test Tube Hydraulic (no fault state)
    _processEquipment(9, data);
    // Test Tube Limit Switch A (fault state if switch B is activated but not A)
    _processEquipment(10, data);
    _processEquipment(11, data);
    // Test Tube Limit Switch B (no fault state)
    _processEquipment(12, data);
    // Antidote Electromagnet (fault state with door sensor)
    _processEquipment(13, data);
    _processEquipment(14, data);
    // Lever Electromagnet (fault state with door sensor)
    _processEquipment(15, data);
    _processEquipment(16, data);
    // Antidote Door Sensor (fault state with electromagnet)
    _processEquipment(17, data);
    _processEquipment(18, data);
    // Lever Door Sensor (fault state with electromagnet)
    _processEquipment(19, data);
    _processEquipment(20, data);
    // Emergency Lever (fault state with electromagnet and door sensor)
    _processEquipment(21, data);
    _processEquipment(22, data);
    // Exit Door Electromagnet (fault state with door sensor)
    _processEquipment(23, data);
    _processEquipment(24, data);
    // Exit Door Sensor (fault state with electromagnet)
    _processEquipment(25, data);
    _processEquipment(26, data);

    // Only update GUI if any data change detected
    if(changesMade == true) {
      super.notifyCallbacks();
    }
    super.updateData(data);
    changesMade = false;
  }

  void _processEquipment(int index, List<bool> data){
    if(super.equipmentDataList[index].state != data[index]){
      super.equipmentDataList[index].updateState(data[index]);
      changesMade = true;
    }
  }
}