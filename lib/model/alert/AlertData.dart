import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final Map<String, Color> _priorityColorMap = {
  "1 - Alarm" : Colors.red,
  "2 - Attention" : Colors.red,
  "3 - Warning" : Colors.orange,
  "4 - Info" : Colors.blue,
};

class AlertData{
  final String id;
  final String title;
  final String description;
  final String reference;

  final Color activeColor;
  late Color inactiveColor;
  late Color acknowledgedColor;

  final String alertText;
  late bool active;
  late bool acknowledge;
  late String timeString;
  late DateTime dateTime;

  AlertData({required this.id, required this.title, required this.description, required this.reference, required this.alertText, required this.active, required this.activeColor}){
    inactiveColor = Colors.black;
    acknowledgedColor = Colors.grey.withAlpha(50);
    acknowledge = false;
    if(active == true) {
      timeString = getNowTimeString();
    }
    else{
      timeString = "00:00:00";
    }
  }

  void updateState(bool activeState, bool acknowledgeState){
    // Detect if transitioning from inactive to active state
    bool activated = false;
    if(active == false && activeState == true){
      activated = true;
    }
    // Always update alarm active state
    active = activeState;

    // If alarm becomes inactive, revert acknowledge state to false
    if(active == false) {
      acknowledge = false;
      return;
    }

    // If alarm is active, update acknowledge state with user input
    if(active == true) {
      acknowledge = acknowledgeState;

      if(activated == true) {
        timeString = getNowTimeString();
      }
    }
  }

  String getNowTimeString(){
    DateTime dt = DateTime.now();
    String hour = dt.hour.toString();
    String minute = dt.minute.toString();
    String second = dt.second.toString();
    return "$hour:$minute:$second";
  }

  AlertData clone([bool isActive = false]){
    return AlertData(
      id: id,
      reference: reference,
      description: description,
      title: title,
      active: isActive,
      alertText: '',
      activeColor: Colors.black,
    );
  }
}


class AlertDataSource extends DataGridSource{
  List<DataGridRow> dataGridRows = [];
  List<AlertData> alertList = [];


  AlertDataSource({required List<AlertData> alerts}) {
    alertList = [];
  }

  void initDataGridRows(List<AlertData> alerts){
    this.alertList = alerts;
    dataGridRows = this.alertList
        .map<DataGridRow>((dataGridRow) =>
        DataGridRow(cells: [
          DataGridCell<String>(columnName: 'Time', value: dataGridRow.timeString),
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

  void updateGridSource(List<AlertData> alerts){
    initDataGridRows(alerts);
    notifyListeners();
    print("UPDATE");
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
}
