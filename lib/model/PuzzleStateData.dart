import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum PuzzleState {
  Completed,
  Attempted,
  NotAttempted,
  InProgress,
  NotMonitored,
  Bypassed,
}

final Map<String, Color> _statusColorMap = {
  "Completed" : Colors.green,
  "Attempted" : Colors.orange,
  "Not Attempted" : Colors.grey,
  "In Progress" : Colors.blue,
  "Not Monitored" : Colors.grey.withAlpha(50),
  "Bypassed" : Colors.teal,
};

class PuzzleStateData{
  final String reference;
  final String name;
  final String description;
  final PuzzleState state;

  late String stateText;

  PuzzleStateData({required this.reference, required this.name, required this.description, required this.state}) {
    switch(this.state){
      case PuzzleState.Completed:
        this.stateText = "Completed";
        break;
      case PuzzleState.Attempted:
        this.stateText = "Attempted";
        break;
      case PuzzleState.NotAttempted:
        this.stateText = "Not Attempted";
        break;
      case PuzzleState.InProgress:
        this.stateText = "In Progress";
        break;
      case PuzzleState.NotMonitored:
        this.stateText = "Not Monitored";
        break;
      case PuzzleState.Bypassed:
        this.stateText = "Bypassed";
        break;
    }

  }

}


class PuzzleStateDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];


  PuzzleStateDataSource({required List<PuzzleStateData> puzzleStates}) {
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
                  color: dataGridCell.columnName == 'Status' ? _statusColorMap[dataGridCell.value] : Colors.black,
                ),
                softWrap: true,
              ));
        }).toList());
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
}