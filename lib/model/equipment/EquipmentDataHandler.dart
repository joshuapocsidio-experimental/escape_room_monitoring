import 'package:flutter_windows/model/plc/PLCTagData.dart';

import '../DataNotifier.dart';
import 'EquipmentData.dart';

// TODO : Turn this into an abstract class
abstract class EquipmentDataHandler extends DataNotifier{
  // Update Data
  void readData(List<bool> digitalInputs, List<int> analogInputs);

  // Data Source
  late final EquipmentDataSource equipmentDataSource;
  // Data list and map
  final List<EquipmentData> equipmentDataList = [];
  final Map<String, EquipmentData> equipmentDataMap = {};

  void updateStateByRef(String id, bool state) {
    _updateState(id, state);
    notifyCallbacks();
  }

  void updateStateByIndex(int idx, bool state){
    String id = equipmentDataList[idx].equipReference;
    _updateState(id, state);
    notifyCallbacks();
  }

  void _updateState(String id, bool state){
    equipmentDataMap[id]!.updateState(state);
  }

  void updateTable(){
    equipmentDataSource.updateGridSource(equipmentDataList);
  }

  void addEquipment(List<List<String>> equipmentStringList){
    String equipRef, equipName, equipDesc, onText, offText, ref;
    String plcTag, plcAddress, plcType, plcDescription;

    for(int i = 0; i < equipmentStringList.length; i++){
      List<String> equipmentString = equipmentStringList[i];

      equipRef = equipmentString[0];
      equipName = equipmentString[1];
      equipDesc = equipmentString[2];
      onText = equipmentString[3];
      offText = equipmentString[4];
      ref = equipmentString[5];

      plcTag = equipmentString[6];
      plcAddress = equipmentString[7];
      plcType = equipmentString[8];
      plcDescription = equipmentString[9];
      PLCTagData plcTagData = PLCTagData(tag: plcTag, dataType: plcType, tagAddress: plcAddress, description: plcDescription);

      EquipmentData newEquipmentData = createEquipment(equipRef, ref, equipName, equipDesc, onText, offText, plcTagData);
      equipmentDataList.add(newEquipmentData);
      equipmentDataMap[equipRef] = newEquipmentData;
    }
  }

  /// INITIAL
  EquipmentData createEquipment(String equipRef, String ref, String equipName, String equipDesc, String onText, String offText, PLCTagData plcTagData){
    return EquipmentData(equipReference: equipRef, reference: ref, offText: offText, description: equipDesc, name: equipName, onText: onText, plcTagData: plcTagData);
  }
}