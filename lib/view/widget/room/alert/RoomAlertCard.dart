import 'dart:async';

import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_windows/model/DataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'AlertDataTable.dart';

class RoomAlertCard extends StatefulWidget {
  @override
  _RoomAlertCardState createState() => _RoomAlertCardState();
}

class _RoomAlertCardState extends State<RoomAlertCard> {
  bool ackEnable = true;
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    DataHandler dataHandler = RoomPage.of(context).dataHandler;
    return Card(
      child: Column(
        children: [
          const Text(
            "Alerts Log",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          CommandBar(
            mainAxisAlignment: MainAxisAlignment.start,
            primaryItems: [
              CommandBarButton(
                label: Text('Acknowledge'),
                icon: Icon(FluentIcons.check_mark),
                onPressed: () async {
                  dataHandler.sendCommand(10, true);
                  dataHandler.alertDataHandler.acknowledgeAll();
                },
              ),
              CommandBarButton(
                  label: Text('Clear'),
                  icon: Icon(FluentIcons.clear_selection),
                  onPressed: () {
                  }
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Divider(),
          ),
           Expanded(
             child: ContextMenuOverlay(
               child: AlertDataTable(
                 alertDataHandler: dataHandler.alertDataHandler,
                 dataGridController: _dataGridController,
               ),
             ),
           ),
        ],
      ),
    );
  }
}
