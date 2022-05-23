import 'package:fluent_ui/fluent_ui.dart';
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

  final String onText;
  final String offText;

  late String stateText;

  EquipmentData({required this.equipReference, required this.name, required this.description, required this.reference, required this.onText, required this.offText}) {
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
}

class EquipmentDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];
  List<EquipmentData> equipmentStates = [];

  EquipmentDataSource({required List<EquipmentData> equipmentStates}) {
    this.equipmentStates = equipmentStates;
    initDataGridRows();
  }

  void initDataGridRows(){
    dataGridRows = this.equipmentStates
        .map<DataGridRow>((dataGridRow) =>
        DataGridRow(cells: [
          DataGridCell<String>(columnName: 'EquipRef', value: dataGridRow.equipReference),
          DataGridCell<String>(columnName: 'Equipment', value: dataGridRow.name),
          DataGridCell<String>(columnName: 'Description', value: dataGridRow.description),
          DataGridCell<String>(columnName: 'Status', value: dataGridRow.stateText),
          DataGridCell<String>(columnName: 'Ref', value: dataGridRow.reference),
        ])).toList();
  }


  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {

          return Container(
              alignment: (dataGridCell.columnName == 'Ref' ||
                  dataGridCell.columnName == 'EquipRef')
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
              ));
        }).toList());
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void updateGridSource(){
    initDataGridRows();
    notifyListeners();
  }
}