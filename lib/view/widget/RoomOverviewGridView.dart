import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/RoomOverviewStageCard.dart';

class RoomOverviewGridView extends StatefulWidget {
  @override
  _RoomOverviewGridViewState createState() => _RoomOverviewGridViewState();
}

class _RoomOverviewGridViewState extends State<RoomOverviewGridView> {
  List<Widget> _stageBoxes = [
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
    RoomOverviewStageCard(color: Colors.grey.withAlpha(70), label: "5",),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 12,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            children: _stageBoxes,
          ),
        ),
      ],
    );
  }
}
