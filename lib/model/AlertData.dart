import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum AlertType{
  Warning,
  Attention,
  Alarm,
  Info,
}

final Map<String, Color> _priorityColorMap = {
  "1 - Alarm" : Colors.red,
  "2 - Attention" : Colors.red,
  "3 - Warning" : Colors.orange,
  "4 - Info" : Colors.blue,
};

class AlertData{
  final AlertType type;
  final String time;
  final String title;
  final String description;
  final String reference;

  late String alertText;

  AlertData({required this.time, required this.type, required this.title, required this.description, required this.reference}){
    switch(type){
      case AlertType.Warning:
        this.alertText = "3 - Warning";
        break;
      case AlertType.Attention:
        this.alertText = "2 - Attention";
        break;
      case AlertType.Alarm:
        this.alertText = "1 - Alarm";
        break;
      case AlertType.Info:
        this.alertText = "4 - Info";
        break;
    }
  }
}


class AlertDataSource extends DataGridSource{
  List<DataGridRow> dataGridRows = [];


  AlertDataSource({required List<AlertData> alerts}) {
    dataGridRows = alerts
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'Time', value: dataGridRow.time),
      DataGridCell<String>(columnName: 'Title', value: dataGridRow.title),
      DataGridCell<String>(columnName: 'Description', value: dataGridRow.description),
      DataGridCell<String>(columnName: 'Priority', value: dataGridRow.alertText),
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
                maxLines: dataGridCell.columnName == 'Title' || dataGridCell.columnName == 'Description' ? 2 : 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: dataGridCell.columnName == "Priority" ? _priorityColorMap[dataGridCell.value] : Colors.black,
                ),
              ));
        }).toList());
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
}
