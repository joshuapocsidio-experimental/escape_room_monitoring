import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/equipment/EquipmentData.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/model/puzzle/PuzzleData.dart';
import 'package:flutter_windows/model/puzzle/PuzzleDataHandler.dart';
import 'package:flutter_windows/view/widget/room/overview/RoomOverviewEquipmentCard.dart';
import 'RoomOverviewStageCard.dart';

class RoomOverviewGridView extends StatefulWidget {
  late bool toggle;
  int numColumns;

  final PuzzleDataHandler puzzleDataHandler;
  final EquipmentDataHandler equipmentDataHandler;

  RoomOverviewGridView({required this.toggle, required this.numColumns, required this.puzzleDataHandler, required this.equipmentDataHandler});

  @override
  _RoomOverviewGridViewState createState() => _RoomOverviewGridViewState();
}

class _RoomOverviewGridViewState extends State<RoomOverviewGridView> {
  late PuzzleDataSource _puzzleStateDataSource;
  late List<PuzzleData> _puzzleStateData;

  late EquipmentDataSource _equipmentStateDataSource;
  late List<EquipmentData> _equipmentStateData;
  final ScrollController _verticalScrollController = ScrollController();

  List<Widget> gridWidgets = [];

  void _refreshGrid(){
    setState(() {
      _puzzleStateDataSource.updateGridSource();
      _equipmentStateDataSource.updateGridSource();
    });
  }
  @override
  void dispose() {
    widget.puzzleDataHandler.removeCallback(_refreshGrid);
    super.dispose();
  }

  @override
  void initState() {
    // Puzzles
    _puzzleStateData = widget.puzzleDataHandler.puzzleDataList;                   // Extract all puzzle data from puzzle data handler
    _puzzleStateDataSource = widget.puzzleDataHandler.puzzleDataSource;           // Extract data source for grid view callback
    widget.puzzleDataHandler.addCallback(_refreshGrid);                           // Add callback to puzzle data handler
    // Equipment
    _equipmentStateData = widget.equipmentDataHandler.equipmentDataList;          // Extract all equipment data from equipment data handler
    _equipmentStateDataSource = widget.equipmentDataHandler.equipmentDataSource;  // Extract data source for grid view callback
    widget.equipmentDataHandler.addCallback(_refreshGrid);                        // Add callback to equipment data handler

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: GridView.builder(
            controller: _verticalScrollController,
            itemCount: widget.toggle == false ? _puzzleStateData.length : _equipmentStateData.length,
            itemBuilder: (BuildContext context, int index) {
              Widget gridBlock;

              if(widget.toggle == false) {
                PuzzleData puzzleData = _puzzleStateData[index];
                gridBlock = RoomOverviewStageCard(color: PuzzleStateContainerColorMap[puzzleData.stateText], label: puzzleData.reference);
              }
              else {
                EquipmentData equipmentData = _equipmentStateData[index];
                gridBlock = RoomOverviewEquipmentCard(color: EquipmentStatusContainerColorMap[equipmentData.stateText], label: equipmentData.equipReference, subLabel: equipmentData.reference,);
              }
              return Container(child: gridBlock);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.numColumns,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              childAspectRatio: 1,
            ),
          ),
        ),
      ],
    );
  }
}