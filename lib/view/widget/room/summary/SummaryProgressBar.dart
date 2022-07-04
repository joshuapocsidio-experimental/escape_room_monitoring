import 'package:fluent_ui/fluent_ui.dart';

class SummaryProgressBar extends StatefulWidget {
  @override
  _SummaryProgressBarState createState() => _SummaryProgressBarState();
}

class _SummaryProgressBarState extends State<SummaryProgressBar> {
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
            value: 55,
            backgroundColor: Colors.grey,
            activeColor: Colors.blue,
          ),
        ),
        const Expanded(
          flex: 3,
          child: const Text(
            "55%",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
