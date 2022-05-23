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

      PuzzleData newPuzzleData = createPuzzle(puzzleRef, puzzleName, puzzleDesc, monitored);
      puzzleDataList.add(newPuzzleData);
      puzzleDataMap[puzzleRef] = newPuzzleData;
    }
  }

  /// INITIAL
  PuzzleData createPuzzle(String reference, String name, String description, String monitored){
    PuzzleState puzzleState;

    if(monitored == "yes") puzzleState = PuzzleState.Incomplete;
    else if(monitored == "no") puzzleState = PuzzleState.NotMonitored;
    else puzzleState = PuzzleState.NotMonitored; // TODO : Throw Exception

    return PuzzleData(reference: reference, description: description, name: name, state: puzzleState);
  }


  @override
  void updateData(List<bool> data) {
    super.updateData(data);
  }
}