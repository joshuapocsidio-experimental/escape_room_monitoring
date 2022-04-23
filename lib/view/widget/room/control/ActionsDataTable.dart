import 'package:data_table_2/data_table_2.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_windows/model/ActionData.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ActionsDataTable extends StatefulWidget {
  @override
  _ActionsDataTableState createState() => _ActionsDataTableState();
}

class _ActionsDataTableState extends State<ActionsDataTable> {
  late ActionDataSource _actionDataSource;
  @override
  void initState() {
    _actionDataSource = ActionDataSource(actions: _actionData);
    super.initState();
  }

  List<ActionData> _actionData = [
    ActionData(time: "11:38", type: ActionType.Game, description: "Game has been resetted", reference: "-"),
    ActionData(time: "12:00", type: ActionType.Game, description: "Game has been started", reference: "-"),
    ActionData(time: "12:20", type: ActionType.Hint, description: "Hint #2 has been sent", reference: "03"),
    ActionData(time: "12:55", type: ActionType.Timer, description: "Timer has been increased by 10 minutes", reference: "-"),
    ActionData(time: "12:32", type: ActionType.Hint, description: "Hint #3 has been sent", reference: "-"),
    ActionData(time: "12:45", type: ActionType.Bypass, description: "Puzzle #5 has been bypassed", reference: "5"),
    ActionData(time: "12:57", type: ActionType.Bypass, description: "Puzzle #8 has been bypassed", reference: "8"),
  ];

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
        source: _actionDataSource,
        columns: [
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              columnName: 'Time',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Time',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              columnName: 'Type',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Type',
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
