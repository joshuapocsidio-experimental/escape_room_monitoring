import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/room/RoomDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';

class TimerProgressBar extends StatefulWidget {
  @override
  _TimerProgressBarState createState() => _TimerProgressBarState();
}

class _TimerProgressBarState extends State<TimerProgressBar> {
  @override
  Widget build(BuildContext context) {
    RoomDataHandler _summaryDataHandler = RoomPage.of(context).dataHandler.roomDataHandler;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
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
            "36:00/${_summaryDataHandler.getRoom().maxTime}:00",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
