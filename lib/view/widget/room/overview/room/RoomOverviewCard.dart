import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_windows/model/room/GameData.dart';
import 'package:flutter_windows/model/room/GameDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';

import '../../../utility/GameControlCommandBar.dart';
import '../../../utility/GameProgressBar.dart';
import '../../../utility/GenericStatusTile.dart';
import '../../../utility/TimerControlCommandBar.dart';
import '../../../utility/TimerProgressBar.dart';

class RoomOverviewCard extends StatefulWidget {
  @override
  _RoomOverviewCardState createState() => _RoomOverviewCardState();
}

class _RoomOverviewCardState extends State<RoomOverviewCard> {
  late GameState gameState;
  late String timeString;
  late GameDataHandler _gameDataHandler;

  @override
  void initState() {
    super.initState();
  }

  void _refreshOverview() {
    setState(() {
      // print("System Debug: RoomOverviewCard refreshed.");
    });
  }

  @override
  void dispose() {
    _gameDataHandler.removeCallback(_refreshOverview);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _gameDataHandler = RoomPage.of(context).dataHandler.gameDataHandler;
    _gameDataHandler.addCallback(_refreshOverview);
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
                  _gameDataHandler.getGame().name,
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
                    _gameDataHandler.getGame().running == true ? "Running" : "Standby",
                    style: TextStyle(
                      color: _gameDataHandler.getGame().running == true ? Colors.blue : Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: TimerProgressBar(
              progress: _gameDataHandler.getGame().progress,
              maxTime: _gameDataHandler.getGame().maxTime,
              currTimeMin: _gameDataHandler.getGame().currTimeMin,
              currTimeSec: _gameDataHandler.getGame().currTimeSec,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: GameProgressBar(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: GenericStatusTile(
              title: "Audio",
              onStateText: "Playing",
              offStateText: "Standby",
              state: _gameDataHandler.getGame().isAudioPlaying,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: GenericStatusTile(
              title: "Video",
              onStateText: "Playing",
              offStateText: "Standby",
              state: _gameDataHandler.getGame().isVideoPlaying,
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
