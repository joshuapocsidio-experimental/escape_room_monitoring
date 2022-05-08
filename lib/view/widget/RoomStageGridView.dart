import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/RoomOverviewStageCard.dart';

class RoomStageGridView extends StatefulWidget {
  final List<Widget> stageBoxes;
  int numColumns;

  RoomStageGridView({required this.stageBoxes, required this.numColumns});

  @override
  _RoomStageGridViewState createState() => _RoomStageGridViewState();
}

class _RoomStageGridViewState extends State<RoomStageGridView> {
  final ScrollController _verticalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            controller: _verticalScrollController,
            crossAxisCount: widget.numColumns,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            children: widget.stageBoxes,
          ),
        ),
      ],
    );
  }
}
