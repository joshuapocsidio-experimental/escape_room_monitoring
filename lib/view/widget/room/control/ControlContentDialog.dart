import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/room/hint/HintDataTable.dart';

class ControlContentDialog extends StatefulWidget {
  @override
  _ControlContentDialogState createState() => _ControlContentDialogState();
}

class _ControlContentDialogState extends State<ControlContentDialog> {
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: BoxConstraints.tightFor(
        width: MediaQuery.of(context).size.width/5,
        height: MediaQuery.of(context).size.height/3,
      ),
      title: const Text("Game Control"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Status",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  FluentIcons.status_circle_inner,
                  color: Colors.green,
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  "Running",
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Divider(),
          ),
          Center(
            child: CommandBar(
              mainAxisAlignment: MainAxisAlignment.center,
              primaryItems: [
                CommandBarButton(
                  icon: Icon(FluentIcons.play),
                  onPressed: () {

                  },
                ),
                CommandBarButton(
                  icon: Icon(FluentIcons.pause),
                  onPressed: () {

                  },
                ),
                CommandBarButton(
                  icon: Icon(FluentIcons.stop),
                  onPressed: () {

                  },
                ),
                CommandBarButton(
                  icon: Icon(FluentIcons.play_resume),
                  onPressed: () {

                  },
                ),
                CommandBarButton(
                  icon: Icon(FluentIcons.reset),
                  onPressed: () {

                  },
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
