import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_windows/model/ActionData.dart';
import 'package:flutter_windows/model/AlertData.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AlarmDataTable extends StatefulWidget {
  @override
  _AlarmDataTableState createState() => _AlarmDataTableState();
}

class _AlarmDataTableState extends State<AlarmDataTable> {
  late AlertDataSource _alertDataSource;
//  final ScrollController _verticalScrollController = ScrollController();
  late ScrollController _scrollController;

  List<AlertData> _alertData = [
    AlertData(time: "11:38", type: AlertType.Warning, title: "Keypad Door Error", description: "System Override has not been solved but the door is open", reference: "2"),
    AlertData(time: "11:50", type: AlertType.Info, title: "Progress Update", description: "Game is 25% complete", reference: "3"),
    AlertData(time: "11:52", type: AlertType.Alarm, title: "Test Tube Limit Switches Position Fault", description: "Limit Switch B is activated but not Limit Switch A", reference: "H, I"),
    AlertData(time: "12:10", type: AlertType.Alarm, title: "Power Supply Fault", description: "24V supply circuit breaker is tripped", reference: "-"),
    AlertData(time: "12:12", type: AlertType.Info, title: "Progress Update", description: "Game is 50% complete", reference: "6"),
    AlertData(time: "12:20", type: AlertType.Attention, title: "Hint Requested", description: "Hint has been requested", reference: "-"),
    AlertData(time: "12:22", type: AlertType.Info, title: "Progress Update", description: "Game is 75% complete", reference: "9"),
    ];

  @override
  void initState() {
    _alertDataSource = AlertDataSource(alerts: _alertData);
    _scrollController = ScrollController();
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
