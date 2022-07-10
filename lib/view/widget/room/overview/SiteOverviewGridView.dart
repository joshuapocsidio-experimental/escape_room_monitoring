import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/equipment/EquipmentData.dart';
import 'package:flutter_windows/model/equipment/EquipmentDataHandler.dart';
import 'package:flutter_windows/model/stage/StageData.dart';
import 'package:flutter_windows/model/stage/StageDataHandler.dart';

import '../../utility/EquipmentStatusBlock.dart';
import '../../utility/StageStatusBlock.dart';

class SiteOverviewGridView extends StatefulWidget {
  late bool toggle;
  int numColumns;

  final StageDataHandler stageDataHandler;
  final EquipmentDataHandler equipmentDataHandler;

  SiteOverviewGridView({required this.toggle, required this.numColumns, required this.stageDataHandler, required this.equipmentDataHandler});

  @override
  _SiteOverviewGridViewState createState() => _SiteOverviewGridViewState();
}

class _SiteOverviewGridViewState extends State<SiteOverviewGridView> {
  late StageDataSource _puzzleStateDataSource;
  late List<StageData> _puzzleStateData;

  late EquipmentDataSource _equipmentStateDataSource;
  late List<EquipmentData> _equipmentStateData;
  final ScrollController _verticalScrollController = ScrollController();

  List<Widget> gridWidgets = [];

  void _refreshGrid(){
    setState(() {
      widget.stageDataHandler.updateWidgets();
      widget.equipmentDataHandler.updateTable();
    });
  }
  @override
  void dispose() {
    widget.stageDataHandler.removeCallback(_refreshGrid);
    super.dispose();
  }

  @override
  void initState() {
    // Puzzles
    _puzzleStateData = widget.stageDataHandler.stageDataList;                   // Extract all puzzle data from puzzle data handler
    _puzzleStateDataSource = widget.stageDataHandler.dataSource;           // Extract data source for grid view callback
    widget.stageDataHandler.addCallback(_refreshGrid);                           // Add callback to puzzle data handler
    // Equipment
    _equipmentStateData = widget.equipmentDataHandler.equipmentDataList;          // Extract all equipment data from equipment data handler
    _equipmentStateDataSource = widget.equipmentDataHandler.equipmentDataSource;  // Extract data source for grid view callback
    widget.equipmentDataHandler.addCallback(_refreshGrid);                        // Add callback to equipment data handler

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: GridView.builder(
            controller: _verticalScrollController,
            itemCount: widget.toggle == false ? _puzzleStateData.length : _equipmentStateData.length,
            itemBuilder: (BuildContext context, int index) {
              Widget gridBlock;

              if(widget.toggle == false) {
                StageData puzzleData = _puzzleStateData[index];
                gridBlock = RoomOverviewStageBlock(color: StageStateContainerColorMap[puzzleData.stateText], label: puzzleData.reference);
              }
              else {
                EquipmentData equipmentData = _equipmentStateData[index];
                gridBlock = StageStatusBlock(color: EquipmentStatusContainerColorMap[equipmentData.stateText], label: equipmentData.equipReference, subLabel: equipmentData.reference,);
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