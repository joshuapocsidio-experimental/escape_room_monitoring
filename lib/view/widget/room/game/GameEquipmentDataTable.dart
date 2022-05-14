import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import '../../../../model/equipment/EquipmentData.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:syncfusion_flutter_core/theme.dart';

import '../../../../model/equipment/EquipmentDataHandler.dart';
class GameEquipmentDataTable extends StatefulWidget {
  final EquipmentDataHandler equipmentDataHandler;

  GameEquipmentDataTable({required this.equipmentDataHandler});

  @override
  _GameEquipmentDataTableState createState() => _GameEquipmentDataTableState();
}

class _GameEquipmentDataTableState extends State<GameEquipmentDataTable> {
  late EquipmentDataSource _equipmentStateDataSource;
  late ScrollController _scrollController;
  late List<EquipmentData> _equipmentStateData;
  late Timer _modbusTimer;
  // TODO: TEST ONLY . REMOVE AFTER
  late int counter;
  @override
  void initState() {
    _equipmentStateData = widget.equipmentDataHandler.equipmentDataList;
    _equipmentStateDataSource = EquipmentDataSource(equipmentStates: _equipmentStateData);
    _scrollController = ScrollController();
    widget.equipmentDataHandler.addCallback(_refreshTable);

    _modbusTimer = Timer.periodic(
        Duration(milliseconds: 1000),
            (timer) {
              if(counter % 4 == 0){
                widget.equipmentDataHandler.updateStateByRef('A', false);
                print("OFF - ${widget.equipmentDataHandler.equipmentDataMap['A']!.description} - ${widget.equipmentDataHandler.equipmentDataMap['A']!.state}");
              }
              if(counter % 3 == 0){
                widget.equipmentDataHandler.updateStateByRef('A', true);
                print("ON - ${widget.equipmentDataHandler.equipmentDataMap['A']!.description} - ${widget.equipmentDataHandler.equipmentDataMap['A']!.state}");
              }
              counter++;
        }
    );
    counter = 0;
    super.initState();
  }

  @override
  void dispose() {
    _modbusTimer.cancel();
    super.dispose();
  }

  void _refreshTable(){
    _equipmentStateDataSource.updateGridSource();
    print("refresh");
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
        verticalScrollController: _scrollController,
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
