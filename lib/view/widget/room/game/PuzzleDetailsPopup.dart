import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/alert/AlertData.dart';
import 'package:flutter_windows/model/equipment/EquipmentData.dart';
import 'package:flutter_windows/model/puzzle/PuzzleData.dart';

class PuzzleDetailsPopup extends StatefulWidget {
  final PuzzleData puzzleData;

  PuzzleDetailsPopup({required this.puzzleData});

  @override
  State<PuzzleDetailsPopup> createState() => _PuzzleDetailsPopupState();
}

class _PuzzleDetailsPopupState extends State<PuzzleDetailsPopup> {
  void _updatePopup() {
    setState(() {
      print("Render");
    });
  }

  @override
  void initState() {
    widget.puzzleData.addCallback(_updatePopup);
    super.initState();
  }

  @override
  void dispose() {
    widget.puzzleData.removeCallback(_updatePopup);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width/3),
      title: Column(
        children: [
          const Text("Stage Details"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Divider(),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Table(
              defaultColumnWidth: const IntrinsicColumnWidth(),
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              children: [
                TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 24.0, top: 3.0),
                        child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                        child: Text(widget.puzzleData.reference),
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
                        child: Text(widget.puzzleData.name),
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
                        child: Text(widget.puzzleData.description),
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
                        child: Text(widget.puzzleData.stateText, style: TextStyle(color: PuzzleStateTextColorMap[widget.puzzleData.stateText]),),
                      ),
                    ]
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Button(child: const Text("OK"), onPressed: (){Navigator.pop(context);}),
      ],
    );
  }
}
