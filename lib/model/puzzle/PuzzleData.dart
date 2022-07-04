import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/plc/PLCTagData.dart';
import 'package:flutter_windows/view/widget/plc/PLCTagDataPopup.dart';
import 'package:flutter_windows/view/widget/room/game/PuzzleDetailsPopup.dart';
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

  // PLC Tags
  final PLCTagData readyTag, progressTag, completionTag, bypassTag;

  PuzzleData({required this.reference,
    required this.name, required this.description, required this.state,
    required this.readyTag, required this.progressTag, required this.completionTag, required this.bypassTag
  }) {
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
    this.isBypassed = isBypassed;
    this.inProgress = inProgress;
    this.isCompleted = isCompleted;
    // Does not involve puzzles that aren't monitored as they are not to be updated during game
    if(state == PuzzleState.NotMonitored){
      return;
    }

    // If Bypassed
    if(isBypassed == true){
      state = PuzzleState.Bypassed;
      stateText = "Bypassed";
//      print("Bypass Detected");
      notifyListeners();
      return;
    }

    // If game is in progress
    if(inProgress == true){
      state = PuzzleState.InProgress;
      stateText = "In Progress";
//      print("In Progress Detected");
      notifyListeners();
      return;
    }

    // Check if game is completed or not
    if(isCompleted == true){
      state = PuzzleState.Completed;
      stateText = "Completed";
//      print("Completed Detected");
    }
    else{
      state = PuzzleState.Incomplete;
      stateText = "Incomplete";
//      print("Incomplete Detected");
    }
    notifyListeners();
  }

  // TODO : TEST
  List<Function> callbacks = [];
  void addCallback(Function callback) {
    callbacks.add(callback);
  }
  void removeCallback(Function callback) {
    callbacks.remove(callback);
  }
  void notifyListeners() {
    for(Function callback in callbacks) {
      callback();
    }
  }
}


class PuzzleDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];
  List<PuzzleData> puzzleStates = [];
  late BuildContext context;

  PuzzleDataSource({required List<PuzzleData> puzzleStates}) {
    this.puzzleStates = [];
    initDataGridRows(puzzleStates);
  }

  /// Data Table Grid
  void initDataGridRows(List<PuzzleData> puzzleDataList){
    puzzleStates = puzzleDataList;
    dataGridRows = puzzleStates
        .map<DataGridRow>((dataGridRow) {
          return PuzzleDataGridRow(
              cells: [
                DataGridCell<String>(columnName: 'ID', value: dataGridRow.reference),
                DataGridCell<String>(columnName: 'Stage', value: dataGridRow.name),
                DataGridCell<String>(columnName: 'Description', value: dataGridRow.description),
                DataGridCell<String>(columnName: 'Status', value: dataGridRow.stateText),
              ],
              puzzleData: dataGridRow
          );
        }).toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    PuzzleData puzzleData = puzzleStates[dataGridRows.indexOf(row)];
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {

          return ContextMenuRegion(
            contextMenu: GenericContextMenu(
              buttonConfigs: [
                ContextMenuButtonConfig(
                  "See Puzzle Details",
                  icon: Icon(FluentIcons.apps_content),
                  onPressed: () {

                    showDialog(
                      context: context,
                      builder: (context){
                        return PuzzleDetailsPopup(puzzleData: puzzleData);
                      },
                    );
                  },
                ),
                ContextMenuButtonConfig(
                  "See PLC Data",
                  icon: Icon(FluentIcons.communication_details),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context){
                        return MultiPLCTagDataPopup(plcTagDataMap: {
                          'Ready Status' : puzzleData.readyTag,
                          'Progress Status' : puzzleData.progressTag,
                          'Completion Status' : puzzleData.completionTag,
                          'Bypass Status' : puzzleData.bypassTag,
                        });
                      },
                    );
                  },
                ),
                ContextMenuButtonConfig(
                  "Bypass Control",
                  icon: Icon(FluentIcons.unlock),
                  onPressed: () {

                  },
                ),
              ],
            ),
            child: Container(
                alignment: (dataGridCell.columnName == 'Ref' ||
                    dataGridCell.columnName == 'Time' ||
                    dataGridCell.columnName == "ID"
                )
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
                )),
          );
        }).toList());
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void updateGridSource(List<PuzzleData> puzzleDataList){
    initDataGridRows(puzzleDataList);
    notifyListeners();
  }


}
class PuzzleDataGridRow extends DataGridRow{
  final PuzzleData puzzleData;
  PuzzleDataGridRow({required List<DataGridCell> cells, required this.puzzleData}) : super(cells: cells);
}