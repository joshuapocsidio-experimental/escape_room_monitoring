import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/room/log/gameControl/GameControlDetailsPopup.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class GameControlData {
  final String title;
  final String description;
  final String timeString;
  final String date;

  GameControlData({required this.title, required this.description, required this.timeString, required this.date});
}

class GameControlDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];
  List<GameControlData> gameControlDataList = [];
  late BuildContext context;

  GameControlDataSource({required List<GameControlData> gameControlDataList}) {
    initDataGridRows(gameControlDataList);
  }

  void initDataGridRows(List<GameControlData> gameControlDataList){
    this.gameControlDataList = gameControlDataList;
    dataGridRows = this.gameControlDataList
        .map<DataGridRow>((dataGridRow) {
      return GameControlDataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'Date', value: dataGridRow.date),
          DataGridCell<String>(columnName: 'Time', value: dataGridRow.timeString),
          DataGridCell<String>(columnName: 'Title', value: dataGridRow.title),
          DataGridCell<String>(columnName: 'Description', value: dataGridRow.description),
        ],
        gameControlData: dataGridRow,
      );
    }).toList();
  }


  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // TODO: implement buildRow
    GameControlData gameControlData = gameControlDataList[dataGridRows.indexOf(row)];
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return ContextMenuRegion(
            contextMenu: GenericContextMenu(
              buttonConfigs: [
                ContextMenuButtonConfig(
                  "See Game Control Log Details",
                  icon: Icon(FluentIcons.apps_content),
                  onPressed: () {

                    showDialog(
                      context: context,
                      builder: (context){
                        return StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) setState) {
                              return GameControlDetailsPopup(gameControlData: gameControlData);
                            }
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            child: Container(
                alignment: (dataGridCell.columnName == 'Date' ||
                    dataGridCell.columnName == 'Time'
                )
                    ? Alignment.center
                    : Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  dataGridCell.value.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  softWrap: true,
                )),
          );
        }).toList());
  }
  @override
  List<DataGridRow> get rows => dataGridRows;

  void updateGridSource(List<GameControlData> gameControlDataList){
    initDataGridRows(gameControlDataList);
    notifyListeners();
  }

}

class GameControlDataGridRow extends DataGridRow{
  final GameControlData gameControlData;
  GameControlDataGridRow({required List<DataGridCell> cells, required this.gameControlData}) : super(cells: cells);

}