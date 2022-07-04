import 'package:flutter_windows/model/plc/PLCTagData.dart';

import '../DataObserver.dart';
import 'PuzzleData.dart';

class PuzzleDataHandler extends DataObserver{
  // Data Source
  late final PuzzleDataSource puzzleDataSource;

  final List<PuzzleData> puzzleDataList = [];
  final Map<String, PuzzleData> puzzleDataMap = {};

  final List<Function> callbacks = [];

  void addCallback(Function callback){
    if(callbacks.contains(callback) == false){
      this.callbacks.add(callback);
    }
  }

  void updateWidgets() {
    puzzleDataSource.updateGridSource(puzzleDataList);
  }

  void removeCallback(Function callback){
    callbacks.remove(callback);
  }

  void notifyCallbacks(){
    for(Function callback in callbacks){
      callback();
    }
  }

  void addPuzzle(List<List<String>> puzzleStringList){
    String puzzleRef, puzzleName, puzzleDesc, monitored;

    for(int i = 0; i < puzzleStringList.length; i++){
      List<String> puzzleString = puzzleStringList[i];

      puzzleRef = puzzleString[0];
      puzzleName = puzzleString[1];
      puzzleDesc = puzzleString[2];
      monitored = puzzleString[3];
      // PLC Tags
      PLCTagData rdyTag = PLCTagData(tag: puzzleString[4], tagAddress: puzzleString[5], dataType: puzzleString[6], description: puzzleString[7]);
      PLCTagData prgTag = PLCTagData(tag: puzzleString[8], tagAddress: puzzleString[9], dataType: puzzleString[10], description: puzzleString[11]);
      PLCTagData finTag = PLCTagData(tag: puzzleString[12], tagAddress: puzzleString[13], dataType: puzzleString[14], description: puzzleString[15]);
      PLCTagData bypTag = PLCTagData(tag: puzzleString[16], tagAddress: puzzleString[17], dataType: puzzleString[18], description: puzzleString[19]);

      PuzzleData newPuzzleData = createPuzzle(puzzleRef, puzzleName, puzzleDesc, monitored, rdyTag, prgTag, finTag, bypTag);
      puzzleDataList.add(newPuzzleData);
      puzzleDataMap[puzzleRef] = newPuzzleData;
    }
  }

  /// INITIAL
  PuzzleData createPuzzle(String reference, String name, String description, String monitored, PLCTagData rdyTag, PLCTagData prgTag, PLCTagData finTag, PLCTagData bypTag){
    PuzzleState puzzleState;

    if(monitored == "yes") puzzleState = PuzzleState.Incomplete;
    else if(monitored == "no") puzzleState = PuzzleState.NotMonitored;
    else puzzleState = PuzzleState.NotMonitored; // TODO : Throw Exception

    return PuzzleData(reference: reference, description: description, name: name, state: puzzleState, readyTag: rdyTag, progressTag: prgTag, completionTag: finTag, bypassTag: bypTag);
  }


  @override
  void updateData(List<bool> data) {
    super.updateData(data);
  }
}