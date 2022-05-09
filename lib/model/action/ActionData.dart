import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum ActionType{
  Game,
  Hint,
  Bypass,
  Timer,
}

class ActionData{
  final String description;
  final String reference;
  final String time;
  final ActionType type;

  late String actionString;

  ActionData({required this.description, required this.reference, required this.time, required this.type}){
    switch(type){
      case ActionType.Game:
        this.actionString = "Game Control";
        break;
      case ActionType.Hint:
        this.actionString = "Hint Control";
        break;
      case ActionType.Bypass:
        this.actionString = "Bypass Control";
        break;
      case ActionType.Timer:
        this.actionString = "Timer Control";
        break;
    }
  }
}

class ActionDataSource extends DataGridSource{
  List<DataGridRow> dataGridRows = [];


  ActionDataSource({required List<ActionData> actions}) {
    dataGridRows = actions
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'Time', value: dataGridRow.time),
      DataGridCell<String>(columnName: 'Type', value: dataGridRow.actionString),
      DataGridCell<String>(columnName: 'Description', value: dataGridRow.description),
      DataGridCell<String>(columnName: 'Ref', value: dataGridRow.reference),
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
                maxLines: dataGridCell.columnName == 'Description' ? 2 : 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                ),
                softWrap: true,
              ));
        }).toList());
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
}
