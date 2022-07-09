import 'package:flutter_windows/model/plc/PLCTagData.dart';

import '../DataNotifier.dart';
import 'StageData.dart';

abstract class StageDataHandler extends DataNotifier{
  // Update Data
  void readData(List<bool> digitalInputs, List<int> analogInputs);

  // Data Source
  late final StageDataSource dataSource;

  final List<StageData> stageDataList = [];
  final Map<String, StageData> stageDataMap = {};

  void updateWidgets() {
    dataSource.updateGridSource(stageDataList);
  }

  void addStage(List<List<String>> stageStringList){
    String stageRef, stageName, stageDescription, stageMonitored;

    for(int i = 0; i < stageStringList.length; i++){
      List<String> stageString = stageStringList[i];

      stageRef = stageString[0];
      stageName = stageString[1];
      stageDescription = stageString[2];
      stageMonitored = stageString[3];
      // PLC Tags
      PLCTagData rdyTag = PLCTagData(tag: stageString[4], tagAddress: stageString[5], dataType: stageString[6], description: stageString[7]);
      PLCTagData prgTag = PLCTagData(tag: stageString[8], tagAddress: stageString[9], dataType: stageString[10], description: stageString[11]);
      PLCTagData finTag = PLCTagData(tag: stageString[12], tagAddress: stageString[13], dataType: stageString[14], description: stageString[15]);
      PLCTagData bypTag = PLCTagData(tag: stageString[16], tagAddress: stageString[17], dataType: stageString[18], description: stageString[19]);

      StageData newPuzzleData = createStage(stageRef, stageName, stageDescription, stageMonitored, rdyTag, prgTag, finTag, bypTag);
      stageDataList.add(newPuzzleData);
      stageDataMap[stageRef] = newPuzzleData;
    }
  }

  /// INITIAL
  StageData createStage(String reference, String name, String description, String monitored, PLCTagData rdyTag, PLCTagData prgTag, PLCTagData finTag, PLCTagData bypTag){
    StageState stageState;

    if(monitored == "yes") stageState = StageState.Incomplete;
    else if(monitored == "no") stageState = StageState.NotMonitored;
    else stageState = StageState.NotMonitored; // TODO : Throw Exception

    return StageData(reference: reference, description: description, name: name, state: stageState, readyTag: rdyTag, progressTag: prgTag, completionTag: finTag, bypassTag: bypTag);
  }
}