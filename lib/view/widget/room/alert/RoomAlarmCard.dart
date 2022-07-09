import 'dart:async';

import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_windows/model/DataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'AlarmDataTable.dart';

class RoomAlarmCard extends StatefulWidget {
  @override
  _RoomAlarmCardState createState() => _RoomAlarmCardState();
}

class _RoomAlarmCardState extends State<RoomAlarmCard> {
  bool ackEnable = true;
  final DataGridController _dataGridController = DataGridController();

  void toggleAckButtonEnable() {
    setState(() {
      ackEnable = !ackEnable;
    });
  }

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
                label: Text('Ack'),
                icon: Icon(FluentIcons.check_mark),
                onPressed: () async {
                  dataHandler.mbHandler.sendCommand('10.0.0.23', 0);
                  dataHandler.alertDataHandler.acknowledgeAll();
                  toggleAckButtonEnable();
                  Timer(Duration(seconds: 1), (){
                    print("Ack");
                    print("Ack End");
                  });
                  toggleAckButtonEnable();
                },
              ),
              CommandBarButton(
                  label: Text('Force'),
                  icon: Icon(FluentIcons.clear_selection),
                  onPressed: () {
                    print("Off");
                    dataHandler.mbHandler.writeData('10.0.0.23', 0, false);
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
               child: AlarmDataTable(
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
