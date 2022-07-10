import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/room/GameDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';

class GameProgressBar extends StatefulWidget {
  final int progress;

  GameProgressBar({required this.progress});

  @override
  _GameProgressBarState createState() => _GameProgressBarState();
}

class _GameProgressBarState extends State<GameProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
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
            value: widget.progress.toDouble(),
            backgroundColor: Colors.grey,
            activeColor: Colors.blue,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            "${widget.progress.toString()}%",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
