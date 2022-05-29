import 'package:fluent_ui/fluent_ui.dart';
import '../../../../model/equipment/EquipmentData.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:syncfusion_flutter_core/theme.dart';

import '../../../../model/equipment/EquipmentDataHandler.dart';
class GameEquipmentDataTable extends StatefulWidget {
  final EquipmentDataHandler equipmentDataHandler;

  GameEquipmentDataTable({required this.equipmentDataHandler});

  @override
  _GameEquipmentDataTableState createState() => _GameEquipmentDataTableState();
}

class _GameEquipmentDataTableState extends State<GameEquipmentDataTable> {
  late EquipmentDataSource _equipmentStateDataSource;
  late ScrollController _scrollController;

  @override
  void initState() {
    _equipmentStateDataSource = widget.equipmentDataHandler.equipmentDataSource;  // Extract all equipment data from equipment data handler
    widget.equipmentDataHandler.addCallback(_refreshTable);                       // Add callback to equipment data handler
    _scrollController = ScrollController();
    super.initState();
  }

  void _refreshTable(){
    _equipmentStateDataSource.updateGridSource();
  }

  @override
  Widget build(BuildContext context) {

    return SfDataGridTheme(
      data: SfDataGridThemeData(
        sortIcon: const Icon(
          FluentIcons.sort,
          size: 10,
        ),
      ),
      child: SfDataGrid(
        headerGridLinesVisibility: GridLinesVisibility.horizontal,
        verticalScrollController: _scrollController,
        headerRowHeight: 30,
        allowSorting: true,
        source: _equipmentStateDataSource,
        columns: [
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByColumnName,
              columnName: 'EquipRef',
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    'Equip',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              columnName: 'Equipment',
              maximumWidth: 150,
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    'Equipment',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          GridColumn(
              columnWidthMode: ColumnWidthMode.fill,
              columnName: 'Description',
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    'Description',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              columnName: 'Status',
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    'Status',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          GridColumn(
              columnWidthMode: ColumnWidthMode.fitByColumnName,
              columnName: 'Ref',
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4),
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    'Ref',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
        ],
      ),
    );
  }
}
