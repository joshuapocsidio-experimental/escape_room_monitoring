import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameEquipmentDataTable extends StatefulWidget {
  @override
  _GameEquipmentDataTableState createState() => _GameEquipmentDataTableState();
}

class _GameEquipmentDataTableState extends State<GameEquipmentDataTable> {
  List<DataRow> _rows = [
    DataRow2(
        cells: [
          DataCell(
            Text("A"),
          ),
          DataCell(
            Text("Intro Pushbutton"),
          ),
          DataCell(
            Text("Plays introduction video"),
          ),
          DataCell(
            Text("1"),
          ),
          DataCell(
            Text("Not Pressed", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("B"),
          ),
          DataCell(
            Text("Multi-Notch Controller"),
          ),
          DataCell(
            Text("Activates manual override"),
          ),
          DataCell(
            Text("3"),
          ),
          DataCell(
            Text("Activated", style: TextStyle(color: Colors.blue),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("C"),
          ),
          DataCell(
            Text("Multiple Rotary Switch"),
          ),
          DataCell(
            Text("Activates system override"),
          ),
          DataCell(
            Text("5"),
          ),
          DataCell(
            Text("Activated", style: TextStyle(color: Colors.blue),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("D"),
          ),
          DataCell(
            Text("Electromagnet"),
          ),
          DataCell(
            Text("Holds the keypad door closed"),
          ),
          DataCell(
            Text("5"),
          ),
          DataCell(
            Text("Deactivated", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("E"),
          ),
          DataCell(
            Text("Door Electromagnet"),
          ),
          DataCell(
            Text("Holds the overhead cabinet door closed"),
          ),
          DataCell(
            Text("6"),
          ),
          DataCell(
            Text("Disengaged", style: TextStyle(color: Colors.blue),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("F"),
          ),
          DataCell(
            Text("Test Tube Switch"),
          ),
          DataCell(
            Text("Activates the hydraulic to lower the test tube table"),
          ),
          DataCell(
            Text("9"),
          ),
          DataCell(
            Text("Not Activated", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("G"),
          ),
          DataCell(
            Text("Hydraulic"),
          ),
          DataCell(
            Text("Lowers the test tube table"),
          ),
          DataCell(
            Text("9"),
          ),
          DataCell(
            Text("Not Activated", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("H"),
          ),
          DataCell(
            Text("Limit Switch A"),
          ),
          DataCell(
            Text("Detects if test tube table has been lowered"),
          ),
          DataCell(
            Text("9"),
          ),
          DataCell(
            Text("Not Activated", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("I"),
          ),
          DataCell(
            Text("Limit Switch B"),
          ),
          DataCell(
            Text("Detects if test tube table has reached its physical limit"),
          ),
          DataCell(
            Text("9"),
          ),
          DataCell(
            Text("Not Activated", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("J"),
          ),
          DataCell(
            Text("Door Electromagnet"),
          ),
          DataCell(
            Text("Holds the antidote enclosure door closed"),
          ),
          DataCell(
            Text("9"),
          ),
          DataCell(
            Text("Engaged", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("K"),
          ),
          DataCell(
            Text("Door Electromagnet"),
          ),
          DataCell(
            Text("Holds the lever enclosure door closed"),
          ),
          DataCell(
            Text("9"),
          ),
          DataCell(
            Text("Engaged", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("L"),
          ),
          DataCell(
            Text("Door Sensor"),
          ),
          DataCell(
            Text("Detects if antidote door is open or closed"),
          ),
          DataCell(
            Text("9"),
          ),
          DataCell(
            Text("Closed", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("M"),
          ),
          DataCell(
            Text("Door Sensor"),
          ),
          DataCell(
            Text("Detects if lever door is open or closed"),
          ),
          DataCell(
            Text("9"),
          ),
          DataCell(
            Text("Closed", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("N"),
          ),
          DataCell(
            Text("Lever"),
          ),
          DataCell(
            Text("Activates emergency state"),
          ),
          DataCell(
            Text("11"),
          ),
          DataCell(
            Text("Not Activated", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("O"),
          ),
          DataCell(
            Text("Door Electromagnet"),
          ),
          DataCell(
            Text("Holds the entry/exit door closed"),
          ),
          DataCell(
            Text("11"),
          ),
          DataCell(
            Text("Engaged", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
    DataRow2(
        cells: [
          DataCell(
            Text("P"),
          ),
          DataCell(
            Text("Door Sensor"),
          ),
          DataCell(
            Text("Detects if exit/entry door is open/closed "),
          ),
          DataCell(
            Text("11"),
          ),
          DataCell(
            Text("Engaged", style: TextStyle(color: Colors.black),),
          ),
        ]
    ),
  ];

  List<DataColumn> _cols = [
    DataColumn2(
      size: ColumnSize.S,
      label: Text("Equip."),
    ),
    DataColumn2(
      size: ColumnSize.M,
      label: Text("Equipment"),
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
      smRatio: 0.5,
    );
  }
}
