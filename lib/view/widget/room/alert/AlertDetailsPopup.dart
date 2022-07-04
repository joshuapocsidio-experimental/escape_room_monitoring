import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/alert/AlertData.dart';

class AlertDetailsPopup extends StatefulWidget {
  final AlertData alertData;

  AlertDetailsPopup({required this.alertData});

  @override
  State<AlertDetailsPopup> createState() => _AlertDetailsPopupState();
}

class _AlertDetailsPopupState extends State<AlertDetailsPopup> {
  void _updatePopup() {
    setState(() {
      print("Alert Render");
      print("State: " + widget.alertData.active.toString());
      print("Ack: " + widget.alertData.acknowledge.toString());
    });
  }

  @override
  void initState() {
    widget.alertData.addCallback(_updatePopup);
    super.initState();
  }

  @override
  void dispose() {
    widget.alertData.removeCallback(_updatePopup);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ContentDialog(
      constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width/3),
      title: Column(
        children: const [
          Text("Alert Details"),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
        ],
      ),
      content: Table(
        defaultColumnWidth: const IntrinsicColumnWidth(),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: [
          const TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
                  child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: Text('01/06/2022'),
                ),
              ]
          ),
          TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
                  child: Text('Time', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: Text(widget.alertData.timeString),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: Text(widget.alertData.title),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: Text(widget.alertData.description),
                ),
              ]
          ),
          TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
                  child: Text('Priority', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: Text(widget.alertData.alertText),
                ),
              ]
          ),
          TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
                  child: Text('Recommended Action', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: Text(widget.alertData.recommendedAction),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: widget.alertData.active == true ? Text("Active", style: TextStyle(color: widget.alertData.activeColor),) : Text("Inactive", style: TextStyle(color: widget.alertData.inactiveColor)),
                )
              ]
          ),
          TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
                  child: Text('Acknowledged?', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: widget.alertData.acknowledge == true ? const Text("Yes", style: TextStyle(color: Colors.grey),) : Text("No", style: TextStyle(color: Colors.blue)),
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
