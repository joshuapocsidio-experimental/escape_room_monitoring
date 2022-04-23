import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ActionsDataTable extends StatefulWidget {
  @override
  _ActionsDataTableState createState() => _ActionsDataTableState();
}

class _ActionsDataTableState extends State<ActionsDataTable> {
  List<DataRow> _rows = [
    DataRow2(
        cells: [
          DataCell(
            Text("Game Control"),
          ),
          DataCell(
            Text("Game has been resetted"),
          ),
          DataCell(
            Text("-"),
          ),
          DataCell(
            Text("11:38"),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Game Control"),
          ),
          DataCell(
            Text("Game has been started"),
          ),
          DataCell(
            Text("-"),
          ),
          DataCell(
            Text("12:00"),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Hint Control"),
          ),
          DataCell(
            Text("Hint #2 has been sent"),
          ),
          DataCell(
            Text("3"),
          ),
          DataCell(
            Text("12:20"),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Hint Control"),
          ),
          DataCell(
            Text("Hint #3 has been sent"),
          ),
          DataCell(
            Text("5"),
          ),
          DataCell(
            Text("12:32"),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Bypass Control"),
          ),
          DataCell(
            Text("Puzzle #7 has been bypassed"),
          ),
          DataCell(
            Text("7"),
          ),
          DataCell(
            Text("12:45"),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Timer Control"),
          ),
          DataCell(
            Text("Timer has been increased by 10 minutes"),
          ),
          DataCell(
            Text("-"),
          ),
          DataCell(
            Text("12:55"),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Game Control"),
          ),
          DataCell(
            Text("Game has been resetted"),
          ),
          DataCell(
            Text("-"),
          ),
          DataCell(
            Text("11:38"),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Game Control"),
          ),
          DataCell(
            Text("Game has been started"),
          ),
          DataCell(
            Text("-"),
          ),
          DataCell(
            Text("12:00"),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Hint Control"),
          ),
          DataCell(
            Text("Hint #2 has been sent"),
          ),
          DataCell(
            Text("3"),
          ),
          DataCell(
            Text("12:20"),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Hint Control"),
          ),
          DataCell(
            Text("Hint #3 has been sent"),
          ),
          DataCell(
            Text("5"),
          ),
          DataCell(
            Text("12:32"),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Bypass Control"),
          ),
          DataCell(
            Text("Puzzle #7 has been bypassed"),
          ),
          DataCell(
            Text("7"),
          ),
          DataCell(
            Text("12:45"),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Timer Control"),
          ),
          DataCell(
            Text("Timer has been increased by 10 minutes"),
          ),
          DataCell(
            Text("-"),
          ),
          DataCell(
            Text("12:55"),
          ),
        ]
    ),
  ];

  List<DataColumn> _cols = [
    DataColumn2(
      size: ColumnSize.M,
      label: Text("Type"),
    ),
    DataColumn2(
      size: ColumnSize.L,
      label: Text("Description"),
    ),
    DataColumn2(
      size: ColumnSize.S,
      label: Text("Ref"),
    ),
    DataColumn2(
      size: ColumnSize.S,
      label: Text("Time"),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      headingTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      dataTextStyle: TextStyle(
        fontSize: 13,
        color: Colors.black,
      ),
      border: TableBorder.all(
        color: Colors.grey.withAlpha(80),
        width: 1,
      ),
      columns: _cols,
      rows: _rows,
      showCheckboxColumn: true,
      headingRowColor: MaterialStateColor.resolveWith((states) {
          return Color.alphaBlend(Colors.transparent, Colors.transparent);
        },
      ),
      lmRatio: 4,
      smRatio: 0.7,
      empty: Center(child: Text("End of Table", style: TextStyle(color: Colors.blue),),),
    );
  }
}
