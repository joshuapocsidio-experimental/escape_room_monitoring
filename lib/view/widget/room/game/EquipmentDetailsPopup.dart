import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/alert/AlertData.dart';
import 'package:flutter_windows/model/equipment/EquipmentData.dart';

class EquipmentDetailsPopup extends StatefulWidget {
  final EquipmentData equipmentData;

  EquipmentDetailsPopup({required this.equipmentData});

  @override
  State<EquipmentDetailsPopup> createState() => _EquipmentDetailsPopupState();
}

class _EquipmentDetailsPopupState extends State<EquipmentDetailsPopup> {

  void _updatePopup() {
    setState(() {
      print("Render");
    });
  }

  @override
  void initState() {
    widget.equipmentData.addCallback(_updatePopup);
    super.initState();
  }

  @override
  void dispose() {
    widget.equipmentData.removeCallback(_updatePopup);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width/3),
      title: Column(
        children: [
          const Text("Equipment Details"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Divider(),
          ),
        ],
      ),
      content: Table(
        defaultColumnWidth: const IntrinsicColumnWidth(),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: [
          TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
                  child: Text('Equip. Ref', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: Text(widget.equipmentData.equipReference),
                ),
              ]
          ),
          TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
                  child: Text('Title', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: Text(widget.equipmentData.name),
                ),
              ]
          ),
          TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
                  child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: Text(widget.equipmentData.description),
                ),
              ]
          ),
          TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
                  child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: widget.equipmentData.state == true ?
                  Text(widget.equipmentData.onText, style: TextStyle(color: Colors.blue),) :
                  Text(widget.equipmentData.offText, style: TextStyle(color: Colors.grey)),
                )
              ]
          ),
        ],
      ),
      actions: [
        Button(child: const Text("OK"), onPressed: (){Navigator.pop(context);}),
      ],
    );
  }
}
