import 'package:flutter_windows/controller/data/ModbusHandler.dart';
import 'package:flutter_windows/model/DataController.dart';
import 'package:flutter_windows/model/DataNotifier.dart';
import 'package:flutter_windows/model/game/GameControlData.dart';
import 'package:flutter_windows/model/game/LogObserver.dart';
import 'package:flutter_windows/model/room/GameData.dart';

abstract class GameDataController extends DataController implements LogObserver {
  // protected functions
  void startGame();
  void stopGame();
  void resetGame();
  final GameData gameData;
  // Data Source
  late final GameControlDataSource gameControlDataSource;
  // Timer Add and Subtract fields
  late int timerChangeMinutes;

  final List<GameControlData> gameControlDataList = [];

  GameDataController({required this.gameData, required MBHandler modbusHandler, required String ip}) : super(mbHandler: modbusHandler, ip: ip){
    timerChangeMinutes = 5;
  }

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
    startGame();
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
    stopGame();
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
    resetGame();
    notifyCallbacks();
  }

  void addTimerStartLog() {
    GameControlData startCommandLog = GameControlData(
      date: getCurrentDateString(),
      timeString: getCurrentTimeString(),
      title: "Timer Start",
      description: gameData.running == false ? "Timer countdown commenced" : "Timer countdown resumed at ${gameData.currTime}",
    );
    gameControlDataList.add(startCommandLog);
    notifyCallbacks();
  }

  void addTimerStopLog() {
    GameControlData stopCommandLog = GameControlData(
      date: getCurrentDateString(),
      timeString: getCurrentTimeString(),
      title: "Timer Stop",
      description: "Timer countdown stopped at ${gameData.currTime}",
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