import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_windows/handlers/RoomStateHandler.dart';
import 'package:flutter_windows/view/screen/MainScreen.dart';
import 'package:provider/provider.dart';
import '../../../../model/RoomStateData.dart';
import '../control/ActionsDataTable.dart';

class RoomTabularSummaryCard extends StatefulWidget {
  late String roomName;
  late String id;
  late Color? color;
  String maxMin;

  RoomTabularSummaryCard({required this.roomName, required this.id, this.color, required this.maxMin});
  @override
  _RoomTabularSummaryCardState createState() => _RoomTabularSummaryCardState();
}

class _RoomTabularSummaryCardState extends State<RoomTabularSummaryCard> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Acrylic(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      luminosityAlpha: 0,
      tintAlpha: 0,
      blurAmount: 500,
      elevation: 20,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: IconButton(
                            icon: Icon(FluentIcons.info, size: 25),
                            onPressed: () {
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Text(
                          widget.roomName,
                          style: TextStyle(
                            fontSize: 50,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: IconButton(
                            icon: Icon(FluentIcons.more, size: 25),
                            onPressed: () {
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Status",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 16,
                    child: Text(
                      "Running",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Timer",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 13,
                    child: ProgressBar(
                      value: 75,
                      backgroundColor: Colors.grey,
                      activeColor: Colors.blue,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "36:00/${widget.maxMin}:00",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Progress",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 13,
                    child: ProgressBar(
                      value: 55,
                      backgroundColor: Colors.grey,
                      activeColor: Colors.blue,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "55%",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Audio",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 16,
                    child: Text(
                      "Playing Emergency Audio",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Video",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 16,
                    child: Text(
                      "Standby",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context){
                            return ContentDialog(
                              title: Text("Game Control"),
                              content: Text("This is a placeholder and will be replaced once functionality for game control is implemented."),
                              actions: [
                                Button(child: Text("OK"), onPressed: (){Navigator.pop(context);}),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        "Game Control",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context){
                            return ContentDialog(
                              title: Text("Hint Control"),
                              content: Text("This is a placeholder and will be replaced once functionality for hint system is implemented."),
                              actions: [
                                Button(child: Text("OK"), onPressed: (){Navigator.pop(context);}),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        "Hint Control",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context){
                            return ContentDialog(
                              title: Text("Bypass Control"),
                              content: Text("This is a placeholder and will be replaced once functionality for bypass functionality is implemented."),
                              actions: [
                                Button(child: Text("OK"), onPressed: (){Navigator.pop(context);}),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        "Bypass Control",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context){
                            return ContentDialog(
                              title: Text("Timer Control"),
                              content: Text("This is a placeholder and will be replaced once functionality for timer control is implemented."),
                              actions: [
                                Button(child: Text("OK"), onPressed: (){Navigator.pop(context);}),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        "Timer Control",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,)
          ],
        )
      ),
    );
  }
}
