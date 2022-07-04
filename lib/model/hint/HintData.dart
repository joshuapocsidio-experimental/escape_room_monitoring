import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum HintType {
  VideoHint,
  AudioHint,
  AVHint,
}

final Map<String, HintType> hintTypeMap = {
  "Video" : HintType.VideoHint,
  "Audio" : HintType.AudioHint,
  "Audio/Video" : HintType.AVHint,
};

class HintData {
  final String id;
  final String title;
  final String description;
  late final HintType hintType;
  final String hintTypeString;
  final List<String> affectedStageIDs = [];
  final List<String> affectedEquipmentIDs = [];
  final List<String> affectedEquipmentPLCIDs = [];

  late int sendCounter;
  HintData({required this.id, required this.title, required this.description, required this.hintTypeString}){
    sendCounter = 0;
    hintType = hintTypeMap[hintTypeString]!;
  }

  void incrementCounter() {
    sendCounter++;
  }

  void resetCounter() {
    sendCounter = 0;
  }
}


class HintDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];
  List<HintData> hintStates = [];

  HintDataSource({required List<HintData> hintStates}) {
    this.hintStates = hintStates;
    initDataGridRows();
  }

  void initDataGridRows(){
    dataGridRows = this.hintStates
        .map<DataGridRow>((dataGridRow) =>
        DataGridRow(cells: [
          DataGridCell<String>(columnName: 'ID', value: dataGridRow.id),
          DataGridCell<String>(columnName: 'Title', value: dataGridRow.title),
          DataGridCell<String>(columnName: 'Description', value: dataGridRow.description),
          DataGridCell<String>(columnName: 'Type', value: dataGridRow.hintTypeString),
        ])).toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return ContextMenuRegion(
              contextMenu: GenericContextMenu(
                buttonConfigs: [
                  ContextMenuButtonConfig(
                    "See hint details",
                    icon: Icon(FluentIcons.hint_text),
                    onPressed: () {
                      print("See Hint Details CLICKED");
                    },
                  ),
                  ContextMenuButtonConfig(
                    "Send hint now",
                    icon: Icon(FluentIcons.send),
                    onPressed: () {
                      print("See Hint Details CLICKED");
                    },
                  ),
                ],
              ),
              child: Container(
                  alignment: (dataGridCell.columnName == 'ID' ||
                      dataGridCell.columnName == 'Type')
                      ? Alignment.center
                      : Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    dataGridCell.value.toString(),
                    maxLines: dataGridCell.columnName == 'Description' || dataGridCell.columnName == 'Title' ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    softWrap: true,
                  ),
              ),);
            }).toList());
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void updateGridSource(){
    initDataGridRows();
    notifyListeners();
  }
}