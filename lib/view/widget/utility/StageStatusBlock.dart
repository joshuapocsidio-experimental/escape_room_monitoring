import 'package:fluent_ui/fluent_ui.dart';

class RoomOverviewStageBlock extends StatefulWidget {
  late Color? color;
  late String? label;
  late String? tooltip;

  RoomOverviewStageBlock({this.color, this.label, this.tooltip});

  @override
  _RoomOverviewStageBlockState createState() => _RoomOverviewStageBlockState();
}

class _RoomOverviewStageBlockState extends State<RoomOverviewStageBlock> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Tooltip(
        message: widget.tooltip ?? "This is the description of the puzzle or stage.",
        child: Container(
          decoration: BoxDecoration(
            color: widget.color ?? Colors.grey,
            border: Border.all(
              color: Colors.grey,
              width: 0.2,
            )
          ),
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
