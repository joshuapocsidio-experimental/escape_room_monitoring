import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/game/GameControlData.dart';

class GameControlDetailsPopup extends StatelessWidget {
  final GameControlData gameControlData;

  GameControlDetailsPopup({required this.gameControlData});

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width/3),
      title: Column(
        children: [
          const Text("Game Control Log Details"),
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
                  child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: Text(gameControlData.date),
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
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  child: Text(gameControlData.timeString),
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
                  child: Text(gameControlData.title),
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
                  child: Text(gameControlData.description),
                ),
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
