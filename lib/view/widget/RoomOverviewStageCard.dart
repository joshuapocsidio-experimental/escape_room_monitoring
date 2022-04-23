import 'package:fluent_ui/fluent_ui.dart';

class RoomOverviewStageCard extends StatefulWidget {
  late Color? color;
  late String? label;
  late String? tooltip;

  RoomOverviewStageCard({this.color, this.label, this.tooltip});

  @override
  _RoomOverviewStageCardState createState() => _RoomOverviewStageCardState();
}

class _RoomOverviewStageCardState extends State<RoomOverviewStageCard> {
  List<Widget> cards = [

  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Tooltip(
        message: widget.tooltip ?? "This is the description of the puzzle or stage.",
        child: Container(
          color: widget.color ?? Colors.grey,
          child: Center(
            child: Text(
              widget.label ?? "1",
            ),
          ),
        ),
      ),
    );
  }
}
