import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../view/widget/room/overview/RoomOverviewStageCard.dart';

enum PuzzleState {
  Completed,
  Incomplete,
  InProgress,
  NotMonitored,
  Bypassed,
}

final Map<String, Color> PuzzleStateContainerColorMap = {
  "Completed" : Colors.green,
  "Incomplete" : Colors.grey.withAlpha(50),
  "In Progress" : Colors.blue,
  "Not Monitored" : Colors.grey.withAlpha(10),
  "Bypassed" : Colors.teal,
};

final Map<String, Color> PuzzleStateTextColorMap = {
  "Completed" : Colors.green,
  "Incomplete" : Colors.grey,
  "In Progress" : Colors.blue,
  "Not Monitored" : Colors.grey.withAlpha(50),
  "Bypassed" : Colors.teal,
};

class PuzzleData{
  final String reference;
  final String name;
  final String description;
  late PuzzleState state;
  late bool isCompleted, isBypassed, inProgress;

  late String stateText;

  PuzzleData({required this.reference, required this.name, required this.description, required this.state}) {
    switch(state){
      case PuzzleState.Completed:
        stateText = "Completed";
        break;
      case PuzzleState.Incomplete:
        stateText = "Incomplete";
        break;
      case PuzzleState.InProgress:
        stateText = "In Progress";
        break;
      case PuzzleState.NotMonitored:
        stateText = "Not Monitored";
        break;
      case PuzzleState.Bypassed:
        stateText = "Bypassed";
        break;
    }
    isCompleted = false;
    isBypassed = false;
    inProgress = false;
  }

  void updateState({required bool isCompleted, required bool inProgress, required bool isBypassed}) {
    // Does not involve puzzles that aren't monitored as they are not to be updated during game
    if(state == PuzzleState.NotMonitored){
      return;
    }

    // If Bypassed
    if(isBypassed == true){
      state = PuzzleState.Bypassed;
      stateText = "Bypassed";
      print("Bypass Detected");
      this.isBypassed = true;
      return;
    }
    else{
      isBypassed = false;
    }

    // If game is in progress
    if(inProgress == true){
      state = PuzzleState.InProgress;
      stateText = "In Progress";
      print("In Progress Detected");
      this.inProgress = true;
      return;
    }
    else{
      inProgress = false;
    }

    // Check if game is completed or not
    if(isCompleted == true){
      state = PuzzleState.Completed;
      stateText = "Completed";
      print("Completed Detected");
      this.isCompleted = true;
      return;
    }
    else{
      state = PuzzleState.Incomplete;
      stateText = "Incomplete";
      print("Incomplete Detected");
      this.isCompleted = false;
    }
  }

}


class PuzzleDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];
  List<PuzzleData> puzzleStates = [];

  PuzzleDataSource({required List<PuzzleData> puzzleStates}) {
    this.puzzleStates = puzzleStates;
    initDataGridRows();
  }

  /// Data Table Grid
  void initDataGridRows(){
    dataGridRows = puzzleStates
        .map<DataGridRow>((dataGridRow) =>
        DataGridRow(cells: [
          DataGridCell<String>(columnName: 'Ref', value: dataGridRow.reference),
          DataGridCell<String>(columnName: 'Stage', value: dataGridRow.name),
          DataGridCell<String>(columnName: 'Description', value: dataGridRow.description),
          DataGridCell<String>(columnName: 'Status', value: dataGridRow.stateText),
        ])).toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {

          return Container(
              alignment: (dataGridCell.columnName == 'Ref' ||
                  dataGridCell.columnName == 'Time')
                  ? Alignment.center
                  : Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                dataGridCell.value.toString(),
                maxLines: dataGridCell.columnName == 'Description' || dataGridCell.columnName == 'Stage' ? 2 : 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: dataGridCell.columnName == 'Status' ? PuzzleStateTextColorMap[dataGridCell.value] : Colors.black,
                ),
                softWrap: true,
              ));
        }).toList());
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void updateGridSource(){
    initDataGridRows();
    notifyListeners();
  }


}