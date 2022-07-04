import 'dart:async';

import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_windows/model/DataHandler.dart';
import 'package:flutter_windows/model/alert/AlertData.dart';
import 'package:flutter_windows/model/alert/AlertDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'AlarmDataTable.dart';

class RoomTabularAlarmCard extends StatefulWidget {
  @override
  _RoomTabularAlarmCardState createState() => _RoomTabularAlarmCardState();
}

class _RoomTabularAlarmCardState extends State<RoomTabularAlarmCard> {
  final DataGridController _dataGridController = DataGridController();
  int _currentIndex = 1;
  final radioButtons = [
    'All',
    'Active',
    'Acknowledged',
  ];

  @override
  Widget build(BuildContext context) {
    DataHandler dataHandler = RoomPage.of(context).dataHandler;
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Container(
              child: const Text(
                "Alerts Log",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(radioButtons.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        RadioButton(
                          checked: _currentIndex == index,
                          onChanged: (bool value) {
                            setState(() {
                              _currentIndex = index;
                              dataHandler.alertDataHandler.updateTableMode(_currentIndex);
                              print("Change To: $index");
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        Text(radioButtons[index]),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  );
                }),
              ),
               Expanded(
                 child: CommandBar(
                   mainAxisAlignment: MainAxisAlignment.end,
                   primaryItems: [
                     CommandBarButton(
                       label: Text('Ack'),
                       icon: Icon(FluentIcons.check_mark),
                       onPressed: () async {
                         print("Ack");
                         dataHandler.mbHandler.sendCommand('10.0.0.23', 0);
                         print("Ack End");
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
               ),
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
                 tableMode: _currentIndex,
                 dataGridController: _dataGridController,
               ),
             ),
           ),
        ],
      ),
    );
  }
}
