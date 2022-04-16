import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlarmDataTable extends StatefulWidget {
  @override
  _AlarmDataTableState createState() => _AlarmDataTableState();
}

class _AlarmDataTableState extends State<AlarmDataTable> {
  List<DataRow> _rows = [
    DataRow2(
      cells: [
        DataCell(
          Text("Warning"),
        ),
        DataCell(
          Text("Keypad Door Error"),
        ),
        DataCell(
          Text("Door opened before System Override has been solved"),
        ),
        DataCell(
          Text("2"),
        ),
        DataCell(
          Text("High", style: TextStyle(color: Colors.orange),),
        ),
      ],
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Attention"),
          ),
          DataCell(
            Text("Close to Completion"),
          ),
          DataCell(
            Text("Game is 90% completed"),
          ),
          DataCell(
            Text("-"),
          ),
          DataCell(
            Text("Low", style: TextStyle(color: Colors.blue),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Alarm"),
          ),
          DataCell(
            Text("Power Supply Fault"),
          ),
          DataCell(
            Text("12V control power supply not detected"),
          ),
          DataCell(
            Text("-"),
          ),
          DataCell(
            Text("High", style: TextStyle(color: Colors.orange),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("Attention"),
          ),
          DataCell(
            Text("Hint Requested"),
          ),
          DataCell(
            Text("Hint has been requested for Flight 729"),
          ),
          DataCell(
            Text("-"),
          ),
          DataCell(
            Text("Very High", style: TextStyle(color: Colors.red),),
          ),
        ]
    ),
  ];

  List<DataColumn> _cols = [
    DataColumn2(
      size: ColumnSize.S,
      label: Text("Type"),
    ),
    DataColumn2(
      size: ColumnSize.M,
      label: Text("Name", textAlign: TextAlign.center,),
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
      label: Text("Priority"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DataTable2(
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
          return Color.alphaBlend(Colors.grey.withAlpha(80), Colors.white);
        }
      ),
      lmRatio: 1.7,
      smRatio: 0.5,
      empty: Center(child: Text("End of Table", style: TextStyle(color: Colors.blue),),),
    );
  }
}
