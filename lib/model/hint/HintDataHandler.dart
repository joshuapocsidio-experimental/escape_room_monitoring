import 'package:flutter_windows/model/DataObserver.dart';
import 'package:flutter_windows/model/hint/HintData.dart';

class HintDataHandler extends DataObserver {
  // Data Source
  late final HintDataSource hintDataSource;

  final List<HintData> hintDataList = [];
  final Map<String, HintData> hintDataMap = {};

  final List<Function> callbacks = [];


  void sendHint(String id) {
    hintDataMap[id]!.incrementCounter();
  }

  void resetHint(String id) {
    hintDataMap[id]!.resetCounter();
  }


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

  void addHint(List<List<String>> hintStringList){
    String hintID, hintTitle, hintDescription, hintTypeString;

    for(int i = 0; i < hintStringList.length; i++){
      List<String> hintString = hintStringList[i];

      hintID = hintString[0];
      hintTitle = hintString[1];
      hintDescription = hintString[2];
      hintTypeString = hintString[3];

      HintData newHintData = createHintData(hintID, hintTitle, hintDescription, hintTypeString);
      hintDataList.add(newHintData);
      hintDataMap[hintID] = newHintData;
    }
  }

  /// INITIAL
  HintData createHintData(String hintID, String hintTitle, String hintDescription, String hintTypeString){
    return HintData(id: hintID, title: hintTitle, description: hintDescription, hintTypeString: hintTypeString);
  }
}