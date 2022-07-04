
import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/plc/PLCTagData.dart';
import 'package:flutter_windows/view/widget/plc/PLCTagDataPopup.dart';
import 'package:flutter_windows/view/widget/room/alert/AlertDetailsPopup.dart';
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
  final String recommendedAction;

  // PLC details
  final PLCTagData plcTagData;

  AlertData({required this.id,
    required this.title, required this.description, required this.reference, required this.alertText, required this.active, required this.activeColor,
    required this.plcTagData,
    required this.recommendedAction,
  }){
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
    }

    // If alarm is active, update acknowledge state with user input
    if(active == true) {
      acknowledge = acknowledgeState;

      if(activated == true) {
        timeString = getNowTimeString();
      }
    }
    notifyListeners();
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
      plcTagData: plcTagData,
      recommendedAction: recommendedAction,
    );
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
    print("CALLBACK ALERT");
  }
}


class AlertDataSource extends DataGridSource{
  List<DataGridRow> dataGridRows = [];
  List<AlertData> alertList = [];
  late BuildContext context;


  AlertDataSource({required List<AlertData> alerts}) {
    alertList = [];
    initDataGridRows(alerts);
  }

  void initDataGridRows(List<AlertData> alerts){
    this.alertList = alerts;

    dataGridRows = this.alertList
        .map<DataGridRow>((dataGridRow) {
          return AlertDataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'Time', value: dataGridRow.timeString),
              DataGridCell<String>(columnName: 'Title', value: dataGridRow.title),
              DataGridCell<String>(columnName: 'Description', value: dataGridRow.description),
              DataGridCell<String>(columnName: 'Priority', value: dataGridRow.alertText),
              DataGridCell<String>(columnName: 'Ref', value: dataGridRow.reference),
            ],
            alertData: dataGridRow,
          );
        }
      ).toList();

  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    AlertData alertData = alertList[dataGridRows.indexOf(row)];
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return ContextMenuRegion(
            contextMenu: GenericContextMenu(
              buttonConfigs: [
                ContextMenuButtonConfig(
                  "See Alert Details",
                  icon: Icon(FluentIcons.apps_content),
                  onPressed: () {

                    showDialog(
                      context: context,
                      builder: (context){
                        return AlertDetailsPopup(alertData: alertData);
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
                        return SinglePLCTagDataPopup(plcTagData: alertData.plcTagData,);
                      },
                    );
                  },
                ),
                ContextMenuButtonConfig(
                  "Clear Alert",
                  icon: Icon(FluentIcons.clear_formatting_eraser),
                  onPressed: () {

                  },
                ),
              ],
            ),
            child: Container(
              color: Colors.transparent,
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
                ),
            ),
          );
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

class AlertDataGridRow extends DataGridRow{
  final AlertData alertData;
  AlertDataGridRow({required List<DataGridCell> cells, required this.alertData}) : super(cells: cells);

}
