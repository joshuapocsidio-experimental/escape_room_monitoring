import 'package:fluent_ui/fluent_ui.dart';
import '../../../../model/puzzle/PuzzleData.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../../model/puzzle/PuzzleDataHandler.dart';

class GameStateDataTable extends StatefulWidget {
  final PuzzleDataHandler puzzleDataHandler;

  GameStateDataTable({required this.puzzleDataHandler});
  @override
  _GameStateDataTableState createState() => _GameStateDataTableState();
}

class _GameStateDataTableState extends State<GameStateDataTable> {
  late PuzzleDataSource _puzzleStateDataSource;
  late ScrollController _scrollController;

  @override
  void initState() {
    _puzzleStateDataSource = widget.puzzleDataHandler.puzzleDataSource;   // Extract all puzzle data from puzzle data handler
    widget.puzzleDataHandler.addCallback(_refreshTable);                  // Add callback to puzzle data handler
    _scrollController = ScrollController();
    super.initState();
  }

  void _refreshTable(){
    _puzzleStateDataSource.updateGridSource();
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
        source: _puzzleStateDataSource,
        columns: [
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByColumnName,
              columnName: 'Ref',
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    'Ref',
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
