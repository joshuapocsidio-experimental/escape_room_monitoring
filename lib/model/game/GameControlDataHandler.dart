import 'package:flutter_windows/model/DataNotifier.dart';
import 'package:flutter_windows/model/game/GameControlData.dart';
import 'package:flutter_windows/model/game/LogObserver.dart';
import 'package:flutter_windows/model/room/GameData.dart';

class GameControlDataHandler extends DataNotifier implements LogObserver {
  final GameData roomData;
  // Data Source
  late final GameControlDataSource gameControlDataSource;

  final List<GameControlData> gameControlDataList = [];

  GameControlDataHandler({required this.roomData});

  String getCurrentTimeString() {
    var dt = DateTime.now();
    int hour = dt.hour;
    int minute = dt.minute;
    int second = dt.second;
    return "${hour.toString()}:${minute.toString()}:${second.toString()}";
  }

  String getCurrentDateString() {
    var dt = DateTime.now();
    int year = dt.year;
    int month = dt.month;
    int day = dt.day;
    return "${day.toString()}/${month.toString()}/${year.toString()}";
  }

  void addGameStartLog() {
    GameControlData startCommandLog = GameControlData(
      date: getCurrentDateString(),
      timeString: getCurrentTimeString(),
      title: "Game Start",
      description: "Game program started and timer countdown is activated",
    );
    gameControlDataList.add(startCommandLog);
    notifyCallbacks();
  }

  void addGameStopLog() {
    GameControlData stopCommandLog = GameControlData(
      date: getCurrentDateString(),
      timeString: getCurrentTimeString(),
      title: "Game Stop",
      description: "Game program and timer is stopped",
    );
    gameControlDataList.add(stopCommandLog);
    notifyCallbacks();
  }

  void addGameResetLog() {
    GameControlData resetCommandLog = GameControlData(
      date: getCurrentDateString(),
      timeString: getCurrentTimeString(),
      title: "Game Reset",
      description: "Game program and timer reset activated",
    );
    gameControlDataList.add(resetCommandLog);
    notifyCallbacks();
  }

  void addTimerStartLog([String startTimeString = '']) {
    GameControlData startCommandLog = GameControlData(
      date: getCurrentDateString(),
      timeString: getCurrentTimeString(),
      title: "Timer Start",
      description: startTimeString == '' ? "Timer countdown commenced" : "Timer countdown resumed at $startTimeString",
    );
    gameControlDataList.add(startCommandLog);
    notifyCallbacks();
  }

  void addTimerStopLog(String stopTimeString) {
    GameControlData stopCommandLog = GameControlData(
      date: getCurrentDateString(),
      timeString: getCurrentTimeString(),
      title: "Timer Stop",
      description: "Timer countdown stopped at $stopTimeString",
    );
    gameControlDataList.add(stopCommandLog);
    notifyCallbacks();
  }

  void addTimerResetLog() {
    GameControlData resetCommandLog = GameControlData(
      date: getCurrentDateString(),
      timeString: getCurrentTimeString(),
      title: "Resume Command",
      description: "Timer reset command executed",
    );
    gameControlDataList.add(resetCommandLog);
    notifyCallbacks();
  }

  // Varying Data Logs
  void addTimerAddTimeLog(int addMinutes) {
    GameControlData addTimeCommandLog = GameControlData(
      date: getCurrentDateString(),
      timeString: getCurrentTimeString(),
      title: "Add Time Command",
      description: "Timer has been increased by ${addMinutes.toString()} minutes",
    );
    gameControlDataList.add(addTimeCommandLog);
    notifyCallbacks();
  }
  void addTimerSubtractTimeLog(int subMinutes) {
    GameControlData subTimeCommandLog = GameControlData(
      date: getCurrentDateString(),
      timeString: getCurrentTimeString(),
      title: "Add Time Command",
      description: "Timer has been decreased by ${subMinutes.toString()} minutes",
    );
    gameControlDataList.add(subTimeCommandLog);
    notifyCallbacks();
  }

  @override
  void updateLogs() {
    gameControlDataSource.updateGridSource(gameControlDataList);
  }
}