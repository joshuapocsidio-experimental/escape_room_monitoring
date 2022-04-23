import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameStateDataTable extends StatefulWidget {
  @override
  _GameStateDataTableState createState() => _GameStateDataTableState();
}

class _GameStateDataTableState extends State<GameStateDataTable> {
  List<DataRow> _rows = [
    DataRow2(
        cells: [
          DataCell(
            Text("1"),
          ),
          DataCell(
            Text("Intro"),
          ),
          DataCell(
            Text("Introduction Video"),
          ),
          DataCell(
            Text("Completed", style: TextStyle(color: Colors.green),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("2"),
          ),
          DataCell(
            Text("Hidden Key"),
          ),
          DataCell(
            Text("Hidden Key to be obtained via magnetic dog tag"),
          ),
          DataCell(
            Text("Not Monitored", style: TextStyle(color: Colors.grey),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("3"),
          ),
          DataCell(
            Text("Gun Box Lock"),
          ),
          DataCell(
            Text("Solved by entering numeric code obtained via hints along the gun props."),
          ),
          DataCell(
            Text("Not Monitored", style: TextStyle(color: Colors.grey),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("4"),
          ),
          DataCell(
            Text("Manual Override"),
          ),
          DataCell(
            Text("Solved by sliding notches to correct positions obtained via manual override sheet."),
          ),
          DataCell(
            Text("Completed", style: TextStyle(color: Colors.green),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("5"),
          ),
          DataCell(
            Text("System Override"),
          ),
          DataCell(
            Text("Solved by twisting rotary switches to correct positions."),
          ),
          DataCell(
            Text("Completed", style: TextStyle(color: Colors.green),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("6"),
          ),
          DataCell(
            Text("Keypad Stage"),
          ),
          DataCell(
            Text("Solved via entering numeric codes obtained via manual override sheet and map coordinates."),
          ),
          DataCell(
            Text("Completed", style: TextStyle(color: Colors.green),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("7"),
          ),
          DataCell(
            Text("Infrared Frame Clue"),
          ),
          DataCell(
            Text("Obtain clue via usage of Infrared Camera pointed at picture frame."),
          ),
          DataCell(
            Text("Not Monitored", style: TextStyle(color: Colors.grey),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("8"),
          ),
          DataCell(
            Text("PC Login Password"),
          ),
          DataCell(
            Text("Solved by inputting 'chubby' as password to the login screen."),
          ),
          DataCell(
            Text("Completed", style: TextStyle(color: Colors.green),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("9"),
          ),
          DataCell(
            Text("Test Tube Antidote"),
          ),
          DataCell(
            Text("Solved by pushing down correct test tubes to corresponding slots."),
          ),
          DataCell(
            Text("Not Attempted", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("10"),
          ),
          DataCell(
            Text("Bravo Lock"),
          ),
          DataCell(
            Text("Solved by inputting BRAVO to the lock."),
          ),
          DataCell(
            Text("Not Monitored", style: TextStyle(color: Colors.grey),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("11"),
          ),
          DataCell(
            Text("Emergency Stage"),
          ),
          DataCell(
            Text("Activated by pulling down lever."),
          ),
          DataCell(
            Text("Not Attempted", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
  ];

  List<DataColumn> _cols = [
    DataColumn2(
      size: ColumnSize.S,
      label: Text("Ref"),
    ),
    DataColumn2(
      size: ColumnSize.M,
      label: Text("Stage"),
    ),
    DataColumn2(
      size: ColumnSize.L,
      label: Text("Description"),
    ),
    DataColumn2(
      size: ColumnSize.M,
      label: Text("Status"),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      headingTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
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
      headingRowColor: MaterialStateColor.resolveWith(
              (states) {
            return Color.alphaBlend(Colors.transparent, Colors.transparent);
          }
      ),
      lmRatio: 5,
      smRatio: 0.3,
    );
  }
}
