
import 'dart:async';

import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/DataNotifier.dart';
import 'package:flutter_windows/model/plc/PLCTagData.dart';
import 'package:flutter_windows/view/widget/plc/PLCTagDataPopup.dart';
import 'package:flutter_windows/view/widget/room/alert/AlertDetailsPopup.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AlertData extends DataNotifier{
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

  void updateState(bool activeState){
    // Always update alarm active state
    active = activeState;

    // If alarm becomes inactive, revert acknowledge state to false
    if(active == false) {
      acknowledge = false;
    }

    // If alarm is active, update acknowledge state with user input
    if(activeState == true) {
      timeString = getNowTimeString();
    }
    super.notifyCallbacks();
  }

  void updateAcknowledge(bool acknowledgeState) {
    acknowledge = acknowledgeState;
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
    alertList = alerts;
    dataGridRows = alertList
        .map<DataGridRow>((dataGridRow) {
          return AlertDataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'Time', value: dataGridRow.timeString),
              DataGridCell<String>(columnName: 'Title', value: dataGridRow.title),
              DataGridCell<String>(columnName: 'Description', value: dataGridRow.description),
              DataGridCell<String>(columnName: 'Priority', value: dataGridRow.alertText),
              DataGridCell<String>(columnName: 'Ref', value: dataGridRow.reference),
              DataGridCell<String>(columnName: 'Status', value: dataGridRow.active == true ? "Active" : "Inactive"),
              DataGridCell<String>(columnName: 'Acknowledge', value: dataGridRow.active == false ? "-" : dataGridRow.acknowledge == true ? "Yes" : "No"),
            ],
            alertData: dataGridRow,
          );
        }
      ).toList();
    if(isAnimating == false) _periodicCallback();
  }

  Color rowColor = Colors.white;
  bool isAnimating = false;
  void _periodicCallback() {
    Timer.periodic(const Duration(milliseconds: 750), (timer){
      isAnimating = true;
      if(rowColor == Colors.white) {
        rowColor = const Color.fromARGB(255, 255, 100, 100);
      }
      else {
        rowColor = Colors.white;
      }
      // print("System Debug: Active alert blinking color updated");
      notifyListeners();
    });
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
                  icon: const Icon(FluentIcons.apps_content),
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
                  icon: const Icon(FluentIcons.communication_details),
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
                  icon: const Icon(FluentIcons.clear_formatting_eraser),
                  onPressed: () {

                  },
                ),
              ],
            ),
            child: Container(
              color: alertData.active == true && alertData.acknowledge == false ? rowColor : alertData.active == true && alertData.acknowledge == true ? const Color.fromARGB(255, 255, 100, 100) : Colors.white,
                alignment: (dataGridCell.columnName == 'Ref' ||
                    dataGridCell.columnName == 'Time'||
                    dataGridCell.columnName == 'Status'||
                    dataGridCell.columnName == 'Acknowledge')
                    ? Alignment.center
                    : Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                    dataGridCell.value.toString(),
                    maxLines: dataGridCell.columnName == 'Title' || dataGridCell.columnName == 'Description' ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                ),
            ),
          );
        }).toList());
  }

  void updateGridSource(List<AlertData> alerts){
    initDataGridRows(alerts);
    notifyListeners();
    // print("System Debug: AlertData - Update Grid Source");
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
}

class AlertDataGridRow extends DataGridRow{
  final AlertData alertData;
  AlertDataGridRow({required List<DataGridCell> cells, required this.alertData}) : super(cells: cells);
}

