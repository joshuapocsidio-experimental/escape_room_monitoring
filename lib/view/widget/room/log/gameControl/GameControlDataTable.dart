import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_windows/model/game/GameControlData.dart';
import 'package:flutter_windows/model/game/GameControlDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class GameControlDataTable extends StatefulWidget {
  @override
  _GameControlDataTableState createState() => _GameControlDataTableState();
}

class _GameControlDataTableState extends State<GameControlDataTable> {
  late GameControlDataHandler gameControlDataHandler;
  late GameControlDataSource _gameControlDataSource;
  late ScrollController _scrollController;
  final DataGridController _dataGridController = DataGridController();

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  void _refreshTable(){
    setState(() {
      gameControlDataHandler.updateLogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    gameControlDataHandler = RoomPage.of(context).dataHandler.gameControlDataHandler;
    _gameControlDataSource = gameControlDataHandler.gameControlDataSource;
    gameControlDataHandler.addCallback(_refreshTable);
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        sortIcon: const Icon(
          FluentIcons.sort,
          size: 10,
        ),
      ),
      child: SfDataGrid(
        controller: _dataGridController,
        headerGridLinesVisibility: GridLinesVisibility.horizontal,
        verticalScrollController: _scrollController,
        headerRowHeight: 30,
        allowSorting: true,
        source: _gameControlDataSource,
        columns: [
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              columnName: 'Date',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Date',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
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
        ],
      ),
    );
  }
}
