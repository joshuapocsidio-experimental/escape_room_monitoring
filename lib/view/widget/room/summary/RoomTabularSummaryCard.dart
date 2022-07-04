import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_windows/controller/data/ModbusHandler.dart';
import 'package:flutter_windows/controller/room/flight_room/FlightRoomSummaryDataHandler.dart';
import 'package:flutter_windows/model/room/RoomData.dart';
import 'package:flutter_windows/model/room/RoomDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:flutter_windows/view/widget/room/control/ControlContentDialog.dart';
import 'package:flutter_windows/view/widget/room/hint/HintContentDialog.dart';
import 'package:flutter_windows/view/widget/room/summary/GameControlCommandBar.dart';
import 'package:flutter_windows/view/widget/room/summary/GenericStatusTile.dart';
import 'package:flutter_windows/view/widget/room/summary/SummaryProgressBar.dart';
import 'package:flutter_windows/view/widget/room/summary/TimerControlCommandBar.dart';
import 'package:flutter_windows/view/widget/room/summary/TimerProgressBar.dart';

class RoomTabularSummaryCard extends StatefulWidget {
  @override
  _RoomTabularSummaryCardState createState() => _RoomTabularSummaryCardState();
}

class _RoomTabularSummaryCardState extends State<RoomTabularSummaryCard> {
  late RoomState gameState;
  late String timeString;
  late RoomDataHandler _summaryDataHandler;
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  void _refreshInfo() {
    setState(() {
      print("RUNNING FEEDBACK");
    });
  }

  @override
  Widget build(BuildContext context) {
    _summaryDataHandler = RoomPage.of(context).dataHandler.roomDataHandler;
    _summaryDataHandler.addCallback(_refreshInfo);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: IconButton(
                    icon: const Icon(FluentIcons.info, size: 25),
                    onPressed: () {
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  _summaryDataHandler.getRoom().name,
                  style: const TextStyle(
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: const Icon(FluentIcons.more, size: 25),
                    onPressed: () {
                    },
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Status",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 16,
                  child: Text(
                    _summaryDataHandler.getRoom().running == true ? "Running" : "Standby",
                    style: TextStyle(
                      color: _summaryDataHandler.getRoom().running == true ? Colors.blue : Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: TimerProgressBar(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: SummaryProgressBar(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: GenericStatusTile(
              title: "Audio",
              onStateText: "Playing",
              offStateText: "Standby",
              state: _summaryDataHandler.getRoom().isAudioPlaying,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: GenericStatusTile(
              title: "Video",
              onStateText: "Playing",
              offStateText: "Standby",
              state: _summaryDataHandler.getRoom().isVideoPlaying,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          GameControlCommandBar(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          TimerControlCommandBar(),
        ],
      )
    );
  }
}
