import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/DataNotifier.dart';
import 'package:flutter_windows/model/plc/PLCTagData.dart';
import 'package:flutter_windows/view/widget/plc/PLCTagDataPopup.dart';
import 'package:flutter_windows/view/widget/room/game/stage/StageDetailsPopup.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum StageState {
  Completed,
  Incomplete,
  InProgress,
  NotMonitored,
  Bypassed,
}

final Map<String, Color> StageStateContainerColorMap = {
  "Completed" : Colors.green,
  "Incomplete" : Colors.grey.withAlpha(50),
  "In Progress" : Colors.blue,
  "Not Monitored" : Colors.grey.withAlpha(10),
  "Bypassed" : Colors.teal,
};

final Map<String, Color> StageStateTextColorMap = {
  "Completed" : Colors.green,
  "Incomplete" : Colors.grey,
  "In Progress" : Colors.blue,
  "Not Monitored" : Colors.grey.withAlpha(50),
  "Bypassed" : Colors.teal,
};

class StageData extends DataNotifier{
  final String reference;
  final String name;
  final String description;
  late StageState state;
  late bool isCompleted, isBypassed, inProgress, isFaulted;

  late String stateText;

  // PLC Tags
  final PLCTagData readyTag, progressTag, completionTag, bypassTag;

  StageData({required this.reference,
    required this.name, required this.description, required this.state,
    required this.readyTag, required this.progressTag, required this.completionTag, required this.bypassTag
  }) {
    switch(state){
      case StageState.Completed:
        stateText = "Completed";
        break;
      case StageState.Incomplete:
        stateText = "Incomplete";
        break;
      case StageState.InProgress:
        stateText = "In Progress";
        break;
      case StageState.NotMonitored:
        stateText = "Not Monitored";
        break;
      case StageState.Bypassed:
        stateText = "Bypassed";
        break;
    }
    isCompleted = false;
    isBypassed = false;
    inProgress = false;
    isFaulted = false;
  }

  void updateState({required bool isCompleted, required bool inProgress, required bool isBypassed, required bool isFaulted}) {
    this.isBypassed = isBypassed;
    this.inProgress = inProgress;
    this.isCompleted = isCompleted;
    this.isFaulted = isFaulted;
    // Does not involve puzzles that aren't monitored as they are not to be updated during game
    if(state == StageState.NotMonitored){
      return;
    }

    // If Bypassed
    if(isBypassed == true){
      state = StageState.Bypassed;
      stateText = "Bypassed";
//      print("Bypass Detected");
      super.notifyCallbacks();
      return;
    }

    // If game is in progress
    if(inProgress == true){
      state = StageState.InProgress;
      stateText = "In Progress";
//      print("In Progress Detected");
      super.notifyCallbacks();
      return;
    }

    // Check if game is completed or not
    if(isCompleted == true){
      state = StageState.Completed;
      stateText = "Completed";
//      print("Completed Detected");
    }
    else{
      state = StageState.Incomplete;
      stateText = "Incomplete";
//      print("Incomplete Detected");
    }
    super.notifyCallbacks();
  }
}


class StageDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];
  List<StageData> stageDataList = [];
  late BuildContext context;

  StageDataSource({required List<StageData> stageDataList}) {
    this.stageDataList = [];
    initDataGridRows(stageDataList);
  }

  /// Data Table Grid
  void initDataGridRows(List<StageData> inStageDataList){
    stageDataList = inStageDataList;
    dataGridRows = stageDataList
        .map<DataGridRow>((dataGridRow) {
          return StageDataGridRow(
              cells: [
                DataGridCell<String>(columnName: 'ID', value: dataGridRow.reference),
                DataGridCell<String>(columnName: 'Stage', value: dataGridRow.name),
                DataGridCell<String>(columnName: 'Description', value: dataGridRow.description),
                DataGridCell<String>(columnName: 'Status', value: dataGridRow.stateText),
              ],
              stageData: dataGridRow
          );
        }).toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    StageData stageData = stageDataList[dataGridRows.indexOf(row)];
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
                        return StageDetailsPopup(stageData: stageData);
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
                          'Ready Status' : stageData.readyTag,
                          'Progress Status' : stageData.progressTag,
                          'Completion Status' : stageData.completionTag,
                          'Bypass Status' : stageData.bypassTag,
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
                    color: dataGridCell.columnName == 'Status' ? StageStateTextColorMap[dataGridCell.value] : Colors.black,
                  ),
                  softWrap: true,
                )),
          );
        }).toList());
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void updateGridSource(List<StageData> inStageDataList){
    initDataGridRows(inStageDataList);
    notifyListeners();
  }


}
class StageDataGridRow extends DataGridRow{
  final StageData stageData;
  StageDataGridRow({required List<DataGridCell> cells, required this.stageData}) : super(cells: cells);
}