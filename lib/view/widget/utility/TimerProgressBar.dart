import 'package:fluent_ui/fluent_ui.dart';

class TimerProgressBar extends StatefulWidget {
  final int progress;
  final String maxTime;
  final int currTimeSec;
  final int currTimeMin;

  TimerProgressBar({required this.maxTime, required this.currTimeSec, required this.currTimeMin, required this.progress});
  @override
  _TimerProgressBarState createState() => _TimerProgressBarState();
}

class _TimerProgressBarState extends State<TimerProgressBar> {
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
            value: widget.progress.toDouble(),
            backgroundColor: Colors.grey,
            activeColor: Colors.blue,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            "${widget.currTimeMin.toString().padLeft(2, '0')}:${widget.currTimeSec.toString().padLeft(2, '0')}/${widget.maxTime}:00",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
