import 'package:fluent_ui/fluent_ui.dart';

import 'EquipmentData.dart';

class EquipmentDataHandler{
  final List<EquipmentData> equipmentDataList = [];
  final Map<String, EquipmentData> equipmentDataMap = {};

  void addEquipment(List<List<String>> equipmentStringList){
    String equipRef, equipName, equipDesc, onText, offText, ref;

    for(int i = 0; i < equipmentStringList.length; i++){
      List<String> equipmentString = equipmentStringList[i];

      equipRef = equipmentString[0];
      equipName = equipmentString[1];
      equipDesc = equipmentString[2];
      onText = equipmentString[3];
      offText = equipmentString[4];
      ref = equipmentString[5];

      EquipmentData newEquipmentData = createEquipment(equipRef, ref, equipName, equipDesc, onText, offText);
      equipmentDataList.add(newEquipmentData);
      equipmentDataMap[equipRef] = newEquipmentData;
    }
  }

  /// INITIAL
  EquipmentData createEquipment(String equipRef, String ref, String equipName, String equipDesc, String onText, String offText){
    return EquipmentData(equipReference: equipRef, reference: ref, offText: offText, description: equipDesc, name: equipName, state: EquipmentState.OFF, onText: onText);
  }
}