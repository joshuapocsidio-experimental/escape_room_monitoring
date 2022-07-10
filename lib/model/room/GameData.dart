

enum GameState{
  Running,
  Ready,
  Resetting,
  RequireReset,
  Finished,
  Disconnected,
  Standby,
}

class GameData{
  final String name;
  final String id;
  final String ip;

  late GameState state;
  late String stateText;
  late String maxTime;
  late String remTime;
  late String currTime;
  late int progress;
  late int currTimeSec, currTimeMin;

  late bool running;
  late bool isAudioPlaying;
  late bool isVideoPlaying;

  // Interlocks
  late bool gameReady, gameFinished, gameStandby;
  late bool equipmentReady, equipmentHealthy;
  late bool stagesReady, stagesHealthy;
  late bool powerReady;

  GameData({required this.name, required this.id, required this.ip, required this.maxTime,
  }) {
    this.state = GameState.Disconnected;
    this.stateText = "Disconnected";
    this.remTime = maxTime;
    this.currTime = '00:00';
    this.progress = 0;
    this.running = false;

    currTimeSec = 0;
    currTimeMin = 0;

    isAudioPlaying = false;
    isVideoPlaying = false;

    gameReady = false;
    equipmentReady = false;
    stagesReady = false;
    powerReady = false;

    equipmentHealthy = false;
    stagesHealthy = false;
    gameFinished = false;
    gameStandby = false;
  }

  void updateState() {
    if(running) state = GameState.Running;
    if(gameReady) state = GameState.Ready;
    if(false) state = GameState.Resetting;
    if(false) state = GameState.RequireReset;
    if(gameFinished) state = GameState.Finished;
    if(gameStandby) state = GameState.Standby;
    checkState();
  }

  void checkState() {

    switch(state){
      case GameState.Running:
        this.stateText = "Running";
        break;
      case GameState.Ready:
        this.stateText = "Ready";
        break;
      case GameState.Resetting:
        this.stateText = "Resetting";
        break;
      case GameState.RequireReset:
        this.stateText = "Requires Reset";
        break;
      case GameState.Finished:
        this.stateText = "Finished";
        break;
      case GameState.Disconnected:
        this.stateText = "Disconnected";
        break;
      case GameState.Standby:
        this.stateText = "Standby";
        break;
    }
  }

  void updateTimerProgress(int newTimeMin, int newTimeSec) {
    currTimeSec = newTimeSec;
    currTimeMin = newTimeMin;
    currTime = "${currTimeMin.toString().padLeft(2,'0')}:${currTimeSec.toString().padLeft(2, '0')}";

    int totalTime = (currTimeMin * 60) + currTimeSec;
    // TODO - Change max time to integer versions of time
    int tempMaxTime = 60 * 60;
    progress = (100.0*(totalTime/tempMaxTime)).toInt();
  }
}


