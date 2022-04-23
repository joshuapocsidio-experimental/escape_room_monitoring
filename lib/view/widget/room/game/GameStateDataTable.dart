import 'package:data_table_2/data_table_2.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_windows/model/PuzzleStateData.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class GameStateDataTable extends StatefulWidget {
  @override
  _GameStateDataTableState createState() => _GameStateDataTableState();
}

class _GameStateDataTableState extends State<GameStateDataTable> {
  late PuzzleStateDataSource _puzzleStateDataSource;

  List<PuzzleStateData> _puzzleStateData = [
    PuzzleStateData(reference: '01', name: 'Intro', description: 'Introduction Video', state: PuzzleState.Completed),
    PuzzleStateData(reference: '02', name: 'Hidden Key', description: 'Hidden Key to be obtained via magnetic dog tag', state: PuzzleState.NotMonitored),
    PuzzleStateData(reference: '03', name: 'Gun Box Lock', description: 'Solved by entering numeric code obtained via hints along the gun props', state: PuzzleState.NotMonitored),
    PuzzleStateData(reference: '04', name: 'Manual Override', description: 'Solved by sliding notches to correct positions obtained via manual override sheet', state: PuzzleState.Completed),
    PuzzleStateData(reference: '05', name: 'System Override', description: 'Solved by twisting rotary switches to correct positions', state: PuzzleState.Bypassed),
    PuzzleStateData(reference: '06', name: 'Keypad Stage', description: 'Solved via entering numeric codes obtained via manual override sheet and map', state: PuzzleState.Completed),
    PuzzleStateData(reference: '07', name: 'Infrared Frame', description: 'Obtain clue via usage of infrared camera pointed at picture frame', state: PuzzleState.NotMonitored),
    PuzzleStateData(reference: '08', name: 'PC Login Password', description: 'Solved by inputting "Chubby" as password to the login screen ', state: PuzzleState.Bypassed),
    PuzzleStateData(reference: '09', name: 'Test Tube Antidote', description: 'Solved by pushing down correct test tubes to corresponding slots', state: PuzzleState.NotAttempted),
    PuzzleStateData(reference: '10', name: 'Bravo Lock', description: 'Solved by inputting BRAVO to the lock', state: PuzzleState.NotMonitored),
    PuzzleStateData(reference: '11', name: 'Emergency Stage', description: 'Activated by pulling down lever', state: PuzzleState.NotAttempted),
  ];


  @override
  void initState() {
    _puzzleStateDataSource = PuzzleStateDataSource(puzzleStates: _puzzleStateData);
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
        source: _puzzleStateDataSource,
        columns: [
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
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              columnName: 'Stage',
              maximumWidth: 150,
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomLeft,
                  child: Text(
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
        ],
      ),
    );
  }
}
