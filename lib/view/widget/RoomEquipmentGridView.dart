import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/RoomOverviewStageCard.dart';

class RoomEquipmentGridView extends StatefulWidget {
  final List<Widget> equipmentBoxes;
  int numColumns;

  RoomEquipmentGridView({required this.equipmentBoxes, required this.numColumns});

  @override
  _RoomEquipmentGridViewState createState() => _RoomEquipmentGridViewState();
}

class _RoomEquipmentGridViewState extends State<RoomEquipmentGridView> {
//  final ScrollController _verticalScrollController = ScrollController();
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            controller: _scrollController,
            crossAxisCount: widget.numColumns,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            children: widget.equipmentBoxes,
          ),
        ),
      ],
    );
  }
}
