import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/alert/AlertData.dart';
import 'package:flutter_windows/model/plc/PLCTagData.dart';

class MultiPLCTagDataPopup extends StatelessWidget {
  final Map<String, PLCTagData> plcTagDataMap;
  MultiPLCTagDataPopup({required this.plcTagDataMap});

  List<Widget> buildMultipleDataBlock() {
    List<Widget> multiDataBlock = [];

    for(String title in plcTagDataMap.keys) {
      multiDataBlock.add(buildPLCTagDataTable(title: title, plcTagData: plcTagDataMap[title]!));
    }
    return multiDataBlock;
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width/3),
      title: Column(
        children: const [
          Text("PLC Tag Data"),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: buildMultipleDataBlock(),
      ),
      actions: [
        Button(child: const Text("OK"), onPressed: (){Navigator.pop(context);}),
      ],
    );
  }
}


class SinglePLCTagDataPopup extends StatelessWidget {
  final PLCTagData plcTagData;

  SinglePLCTagDataPopup({required this.plcTagData});

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width/3),
      title: Column(
        children: const [
          Text("PLC Tag Data"),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
        ],
      ),
      content: buildPLCTagDataTable(plcTagData: plcTagData),
      actions: [
        Button(child: const Text("OK"), onPressed: (){Navigator.pop(context);}),
      ],
    );
  }
}

List<TableRow> buildPLCTagDataBlock (PLCTagData plcTagData) {
  return [
    TableRow(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
            child: Text('Tag', style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            child: Text(plcTagData.tag),
          ),
        ]
    ),
    TableRow(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
            child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            child: Text(plcTagData.dataType),
          ),
        ]
    ),
    TableRow(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
            child: Text(
              'Address', style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            child: Text(plcTagData.tagAddress),
          ),
        ]
    ),
    TableRow(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
            child: Text(
              'Description', style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            child: Text(plcTagData.description),
          ),
        ]
    ),
  ];
}

Widget buildPLCTagDataTable ({String title = '', required PLCTagData plcTagData}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: title == '' ? [
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: buildPLCTagDataBlock(plcTagData),
        ),
      ),
    ] :
    [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Divider(),
      ),
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: buildPLCTagDataBlock(plcTagData),
        ),
      ),
    ],
  );
}



