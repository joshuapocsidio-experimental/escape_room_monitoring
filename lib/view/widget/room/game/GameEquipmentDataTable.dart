import 'package:data_table_2/data_table_2.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_windows/model/EquipmentStateData.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:syncfusion_flutter_core/theme.dart';
class GameEquipmentDataTable extends StatefulWidget {
  @override
  _GameEquipmentDataTableState createState() => _GameEquipmentDataTableState();
}

class _GameEquipmentDataTableState extends State<GameEquipmentDataTable> {
  late EquipmentStateDataSource _equipmentStateDataSource;

  List<EquipmentStateData> _equipmentStateData = [
    EquipmentStateData(equipReference: 'A', name: 'Intro Pushbutton', description: 'Plays the introduction video', state: EquipmentState.OFF, onText: 'Pressed', offText: 'Not Pressed', reference: '01'),
    EquipmentStateData(equipReference: 'B', name: 'Multi-Notch Controller', description: 'Activates manual override', state: EquipmentState.ON, onText: 'Activated', offText: 'Deactivated', reference: '04'),
    EquipmentStateData(equipReference: 'C', name: 'Multiple Rotary Switches', description: 'Activates system override', state: EquipmentState.ON, onText: 'Activated', offText: 'Deactivated', reference: '05'),
    EquipmentStateData(equipReference: 'D', name: 'Keypad Electromagnet', description: 'Holds the keypad door closed', state: EquipmentState.OFF, onText: 'Activated', offText: 'Deactivated', reference: '05'),
    EquipmentStateData(equipReference: 'E', name: 'Overhead Cabinet Electromagnet', description: 'Holds the overhead cabinet door closed', state: EquipmentState.ON, onText: 'Disengaged', offText: 'Engaged', reference: '06'),
    EquipmentStateData(equipReference: 'F', name: 'Test Tube Switch', description: 'Activates the hydraulic to lower the test tube table', state: EquipmentState.OFF, onText: 'Activated', offText: 'Deactivated', reference: '09'),
    EquipmentStateData(equipReference: 'G', name: 'Test Tube Hydraulic', description: 'Lowers the test tube table', state: EquipmentState.OFF, onText: 'Activated', offText: 'Deactivated', reference: '09'),
    EquipmentStateData(equipReference: 'H', name: 'Test Tube Limit Switch A', description: 'Detects if test tube table has been lowered', state: EquipmentState.FAULT, onText: 'Activated', offText: 'Deactivated', reference: '09'),
    EquipmentStateData(equipReference: 'I', name: 'Test Tube Limit Switch B', description: 'Detects if test tube table has reached its physical limit', state: EquipmentState.FAULT, onText: 'Activated', offText: 'Deactivated', reference: '09'),
    EquipmentStateData(equipReference: 'J', name: 'Antidote Electromagnet', description: 'Holds the antidote enclosure door closed', state: EquipmentState.ON, onText: 'Disengaged', offText: 'Engaged', reference: '09'),
    EquipmentStateData(equipReference: 'K', name: 'Lever Door Electromagnet', description: 'Holds the lever enclosure door closed', state: EquipmentState.ON, onText: 'Disengaged', offText: 'Engaged', reference: '09'),
    EquipmentStateData(equipReference: 'L', name: 'Antidote Door Sensor', description: 'Detects if antidote door is open or closed', state: EquipmentState.ON, onText: 'Open', offText: 'Closed', reference: '09'),
    EquipmentStateData(equipReference: 'M', name: 'Lever Door Sensor', description: 'Detects if lever door is open or closed', state: EquipmentState.ON, onText: 'Open', offText: 'Closed', reference: '09'),
    EquipmentStateData(equipReference: 'N', name: 'Emergency Lever', description: 'Activates emergency state', state: EquipmentState.OFF, onText: 'Activated', offText: 'Deactivated', reference: '11'),
    EquipmentStateData(equipReference: 'O', name: 'Exit Door Electromagnet', description: 'Holds the entry/exit door closed', state: EquipmentState.OFF, onText: 'Disengaged', offText: 'Engaged', reference: '11'),
    EquipmentStateData(equipReference: 'P', name: 'Exit Door Sensor', description: 'Detects if entry/exit door is closed', state: EquipmentState.OFF, onText: 'Disengaged', offText: 'Engaged', reference: '11'),
  ];

  @override
  void initState() {
    _equipmentStateDataSource = EquipmentStateDataSource(equipmentStates: _equipmentStateData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        sortIcon: const Icon(
          FluentIcons.sort,
          size: 10,
        ),
      ),
      child: SfDataGrid(
        headerGridLinesVisibility: GridLinesVisibility.horizontal,
        headerRowHeight: 30,
        allowSorting: true,
        source: _equipmentStateDataSource,
        columns: [
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByColumnName,
              columnName: 'EquipRef',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Equip',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              columnName: 'Equipment',
              maximumWidth: 150,
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Equipment',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          GridColumn(
              columnWidthMode: ColumnWidthMode.fill,
              columnName: 'Description',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Description',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              columnName: 'Status',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Status',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByColumnName,
              columnName: 'Ref',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Ref',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
        ],
      ),
    );
  }
}
