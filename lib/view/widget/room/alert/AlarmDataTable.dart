import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_windows/model/alert/AlertDataHandler.dart';
import 'package:flutter_windows/model/alert/WarningAlert.dart';
import '../../../../model/action/ActionData.dart';
import '../../../../model/alert/AlertData.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AlarmDataTable extends StatefulWidget {
  final AlertDataHandler alertDataHandler;
  late int tableMode;

  AlarmDataTable({required this.alertDataHandler, required this.tableMode});
  @override
  _AlarmDataTableState createState() => _AlarmDataTableState();
}

class _AlarmDataTableState extends State<AlarmDataTable> {
  late AlertDataSource _alertDataSource;
  late ScrollController _scrollController;


  @override
  void initState() {
    _alertDataSource = widget.alertDataHandler.alertDataSource;  // Extract all equipment data from equipment data handler
    widget.alertDataHandler.addCallback(_refreshTable);                       // Add callback to equipment data handler
    _scrollController = ScrollController();
    super.initState();
  }

  void _refreshTable() {
    widget.alertDataHandler.updateTableMode(widget.tableMode);
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
        source: _alertDataSource,
        allowSorting: true,
        columns: [
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              columnName: 'Time',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Time',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              maximumWidth: 150,
              columnName: 'Title',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Title',
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
              columnName: 'Priority',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Priority',
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
