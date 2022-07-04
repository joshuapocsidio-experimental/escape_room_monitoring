import 'package:fluent_ui/fluent_ui.dart';

class TimerControlCommandBar extends StatefulWidget {
  @override
  _TimerControlCommandBarState createState() => _TimerControlCommandBarState();
}

class _TimerControlCommandBarState extends State<TimerControlCommandBar> {
  late final TextEditingController _addTextEditingController;
  int changeMinute = 5;
  bool editTextEnable = false;

  @override
  void initState() {
    _addTextEditingController = TextEditingController(
      text: "$changeMinute minutes",
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  "Timer Controls",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: CommandBar(
                isCompact: false,
                mainAxisAlignment: MainAxisAlignment.start,
                secondaryItems: [
                  CommandBarButton(
                      icon: const Icon(FluentIcons.info),
                      label: const Text("See Timer Controls Guide"),
                      onPressed: () {

                      }
                  )
                ],
                primaryItems: [
                  CommandBarButton(
                    icon: const Icon(FluentIcons.play),
                    label: const Text("Play"),
                    onPressed: () {

                    },
                  ),
                  const CommandBarSeparator(),
                  CommandBarButton(
                    icon: const Icon(FluentIcons.pause),
                    label: const Text("Pause"),
                    onPressed: () {

                    },
                  ),
                  const CommandBarSeparator(),
                  CommandBarButton(
                    icon: const Icon(FluentIcons.stop),
                    label: const Text("Stop"),
                    onPressed: () {

                    },
                  ),
                  const CommandBarSeparator(),
                  CommandBarButton(
                    icon: const Icon(FluentIcons.play_resume),
                    label: const Text("Resume"),
                    onPressed: () {

                    },
                  ),
                  const CommandBarSeparator(),
                  CommandBarButton(
                    icon: const Icon(FluentIcons.reset),
                    label: const Text("Reset"),
                    onPressed: () {

                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CommandBar(
                mainAxisAlignment: MainAxisAlignment.end,
                primaryItems: [
                  CommandBarButton(
                    icon: const Icon(FluentIcons.add),
                    label: const Text("Add"),
                    onPressed: () {  },
                  ),
                  const CommandBarSeparator(),
                  CommandBarButton(
                    icon: const Icon(FluentIcons.calculator_subtract),
                    label: const Text("Sub"),
                    onPressed: () {  },
                  ),
                  const CommandBarSeparator(),
                ],

              ),
            ),
            SizedBox(
              width: 100,
              child: TextBox(
                controller: _addTextEditingController,
                onEditingComplete: (){
                  setState(() {
                    String minString = _addTextEditingController.text;
                    if(int.tryParse(minString) != null) {
                      _addTextEditingController.text = "$minString minutes";
                    }
                    else{
                      _addTextEditingController.text = "$changeMinute minutes";
                    }
                    editTextEnable = false;
                  });
                },
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                enabled: editTextEnable,
              ),
            ),
            SizedBox(
              width: 30,
              child: OutlinedButton(
                onPressed: editTextEnable == true ? null : () {
                  setState(() {
                    if(changeMinute > 60) {
                      return;
                    }
                    changeMinute++;
                    if(editTextEnable == true) {
                      _addTextEditingController.text = "$changeMinute";
                    }
                    else{
                      _addTextEditingController.text = "$changeMinute minutes";
                    }
                  });
                },
                child: const Icon(
                  FluentIcons.up,
                  size: 10,
                ),
              ),
            ),
            SizedBox(
              width: 30,
              child: OutlinedButton(
                onPressed: editTextEnable == true ? null : () {
                  setState(() {
                    if(changeMinute == 0) {
                      return;
                    }

                    if(editTextEnable == true) {
                      _addTextEditingController.text = "$changeMinute";
                    }
                    else{
                      _addTextEditingController.text = "$changeMinute minutes";
                    }
                  });
                },
                child: const Icon(
                  FluentIcons.down,
                  size: 10,
                ),
              ),
            ),
            SizedBox(
              width: 30,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    editTextEnable = !editTextEnable;
                    _addTextEditingController.text = "$changeMinute";
                  });
                },
                child: const Icon(
                  FluentIcons.pencil_reply,
                  size: 10,
                ),
              ),
            ),

          ],
        ),
      ],
    );
  }
}
