

enum GameState{
  Ongoing,
  Ready,
  Resetting,
  RequireReset,
  Finished,
  Disconnected,
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
  }

  void checkState() {
    switch(state){
      case GameState.Ongoing:
        this.stateText = "Ongoing";
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


