import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/plc/PLCTagData.dart';
import 'package:flutter_windows/view/widget/plc/PLCTagDataPopup.dart';
import 'package:flutter_windows/view/widget/room/game/EquipmentDetailsPopup.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final Map<String, Color> EquipmentStatusContainerColorMap = {};
final Map<String, Color> EquipmentStatusTextColorMap = {};

class EquipmentData{
  final String reference;
  final String equipReference;
  final String name;
  final String description;
  late bool state;
  late bool faulted;
  // PLC details
  final PLCTagData plcTagData;

  final String onText;
  final String offText;

  late String stateText;

  EquipmentData({required this.equipReference,
    required this.name, required this.description, required this.reference, required this.onText, required this.offText,
    required this.plcTagData,
  }) {
    EquipmentStatusContainerColorMap[offText] = Colors.grey.withAlpha(50);
    EquipmentStatusContainerColorMap[onText] = Colors.blue;

    EquipmentStatusTextColorMap[offText] = Colors.black;
    EquipmentStatusTextColorMap[onText] = Colors.blue;
    state = false;
    faulted = false;
    updateState(state);
  }

  void updateState(bool state) {
    this.state = state;
    switch (this.state) {
      case true:
        stateText = onText;
        break;
      case false:
        stateText = offText;
        break;
    }
    notifyListeners();
  }

  void updateFaulted(bool faulted) {
    // TODO : Update this function
    this.faulted = faulted;
    switch (this.faulted) {
      case true:
//        stateText = onText;
        break;
      case false:
//        stateText = offText;
        break;
    }
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

class EquipmentDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];
  List<EquipmentData> equipmentStates = [];
  late BuildContext context;

  EquipmentDataSource({required List<EquipmentData> equipmentStates}) {
    this.equipmentStates = [];
    initDataGridRows(equipmentStates);
  }

  void initDataGridRows(List<EquipmentData> equipmentDataList){
    this.equipmentStates = equipmentDataList;
    dataGridRows = this.equipmentStates
        .map<DataGridRow>((dataGridRow) {
          return EquipmentDataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'ID', value: dataGridRow.equipReference),
              DataGridCell<String>(columnName: 'Equipment', value: dataGridRow.name),
              DataGridCell<String>(columnName: 'Description', value: dataGridRow.description),
              DataGridCell<String>(columnName: 'Status', value: dataGridRow.stateText),
              DataGridCell<String>(columnName: 'Ref', value: dataGridRow.reference),
            ],
            equipmentData: dataGridRow,
          );
        }).toList();
  }


  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    EquipmentData equipmentData = equipmentStates[dataGridRows.indexOf(row)];
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return ContextMenuRegion(
            contextMenu: GenericContextMenu(
              buttonConfigs: [
                ContextMenuButtonConfig(
                  "See Equipment Details",
                  icon: Icon(FluentIcons.apps_content),
                  onPressed: () {

                    showDialog(
                      context: context,
                      builder: (context){
                        return StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) setState) {
                            return EquipmentDetailsPopup(equipmentData: equipmentData);
                          }
                        );
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
                        return StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) setState) {
                            return SinglePLCTagDataPopup(plcTagData: equipmentData.plcTagData);
                          },
                        );
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
                    dataGridCell.columnName == 'EquipRef' ||
                    dataGridCell.columnName == 'ID'
                )
                    ? Alignment.center
                    : Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  dataGridCell.value.toString(),
                  maxLines: dataGridCell.columnName == 'Description' || dataGridCell.columnName == 'Equipment' ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: dataGridCell.columnName == 'Status' ? EquipmentStatusTextColorMap[dataGridCell.value]: Colors.black,
                  ),
                  softWrap: true,
                )),
          );
        }).toList());
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void updateGridSource(List<EquipmentData> equipmentDataList){
    initDataGridRows(equipmentDataList);
    notifyListeners();
  }
}

class EquipmentDataGridRow extends DataGridRow{
  final EquipmentData equipmentData;
  EquipmentDataGridRow({required List<DataGridCell> cells, required this.equipmentData}) : super(cells: cells);

}