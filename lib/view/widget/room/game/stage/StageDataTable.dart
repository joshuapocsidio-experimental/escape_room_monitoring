import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/stage/StageData.dart';
import 'package:flutter_windows/model/stage/StageDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class StageDataTable extends StatefulWidget {
  final StageDataHandler puzzleDataHandler;

  StageDataTable({required this.puzzleDataHandler});
  @override
  _StageDataTableState createState() => _StageDataTableState();
}

class _StageDataTableState extends State<StageDataTable> {
  late StageDataSource _puzzleStateDataSource;
  late ScrollController _scrollController;
  final DataGridController _dataGridController = DataGridController();

  @override
  void initState() {
    _puzzleStateDataSource = widget.puzzleDataHandler.dataSource;   // Extract all puzzle data from puzzle data handler
    widget.puzzleDataHandler.addCallback(_refreshTable);                  // Add callback to puzzle data handler
    _scrollController = ScrollController();
    super.initState();
  }

  void _refreshTable(){
    widget.puzzleDataHandler.updateWidgets();
  }

  @override
  Widget build(BuildContext context) {
    RoomPage.of(context).dataHandler.stageDataHandler.dataSource.context = context;
    RoomPage.of(context).dataHandler.gameDataHandler.addCallback(_refreshTable);
    RoomPage.of(context).dataHandler.stageDataHandler.addCallback(_refreshTable);
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        sortIcon: const Icon(
          FluentIcons.sort,
          size: 10,
        ),
      ),
      child: SfDataGrid(
        rowHeight: 40,
        controller: _dataGridController,
        headerGridLinesVisibility: GridLinesVisibility.horizontal,
        verticalScrollController: _scrollController,
        headerRowHeight: 30,
        allowSorting: true,
        source: _puzzleStateDataSource,
        columns: [
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByColumnName,
              columnName: 'ID',
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    'ID',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              columnName: 'Stage',
              maximumWidth: 150,
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    'Stage',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          GridColumn(
              columnWidthMode: ColumnWidthMode.fill,
              columnName: 'Description',
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomLeft,
                  child: const Text(
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
                  padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    'Status',
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
