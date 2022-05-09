import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum EquipmentState {
  ON,
  OFF,
  FAULT,
}

final Map<String, Color> _statusColorMap = {};

class EquipmentData{
  final String reference;
  final String equipReference;
  final String name;
  final String description;
  final EquipmentState state;

  final String onText;
  final String offText;

  late String stateText;


  EquipmentData({required this.equipReference, required this.name, required this.description, required this.state, required this.reference, required this.onText, required this.offText}) {
    _statusColorMap[onText] = Colors.blue;
    _statusColorMap[offText] = Colors.black;
    _statusColorMap["Fault"] = Colors.red;

    switch(this.state){
      case EquipmentState.ON:
        this.stateText = this.onText;
        break;
      case EquipmentState.OFF:
        this.stateText = this.offText;
        break;
      case EquipmentState.FAULT:
        this.stateText = "Fault";
        break;
    };
  }

}


class EquipmentDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];


  EquipmentDataSource({required List<EquipmentData> equipmentStates}) {
    dataGridRows = equipmentStates
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
                  color: dataGridCell.columnName == 'Status' ? _statusColorMap[dataGridCell.value] : Colors.black,
                ),
                softWrap: true,
              ));
        }).toList());
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
}