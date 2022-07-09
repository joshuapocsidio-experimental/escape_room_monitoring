import 'package:flutter_windows/model/room/GameData.dart';
import 'package:flutter_windows/model/room/GameDataHandler.dart';

class FlightRoomGameDataHandler extends GameDataHandler {
  // Data Flags
  late bool gameStateChanged, gameTimerChanged;
  late bool changeDetected;

  int currSec = 0, currMin = 0;
  List<bool> roomStates = List.filled(10, false);
  // Game Running Status
  late bool FLRM01_GameRnng_S;
  // Media Playing Status
  late bool FLRM01_RPI01_AudRnng_S, FLRM01_RPI01_VidRnng_S;
  // Timer Feedback
  late int FLRM01_TmrDispMin_N, FLRM01_TmrDispSec_N;


  @override
  void readData(List<bool> digitalInputs, List<int> analogInputs) {
    // Flag Resets
    gameStateChanged = false;
    gameTimerChanged = false;
    changeDetected = false;

    // Digital Data
    FLRM01_GameRnng_S = digitalInputs[201];
    FLRM01_RPI01_AudRnng_S = digitalInputs[354];
    FLRM01_RPI01_VidRnng_S = digitalInputs[362];
    _processGameState(FLRM01_GameRnng_S, FLRM01_RPI01_AudRnng_S, FLRM01_RPI01_VidRnng_S);
    FLRM01_TmrDispMin_N = analogInputs[20];
    FLRM01_TmrDispSec_N = analogInputs[21];

    // Analog Data
    _processTimer(FLRM01_TmrDispMin_N, FLRM01_TmrDispSec_N);
    currMin = FLRM01_TmrDispMin_N;
    currSec = FLRM01_TmrDispSec_N;

    // Only update GUI if any data change detected
    changeDetected = gameStateChanged || gameTimerChanged;
    if(changeDetected == true) {
      super.notifyCallbacks();
    }
  }

  void _processTimer(int min, int sec) {
    GameData roomData = super.getGame();
    roomData.updateTimerProgress(currMin, currSec);
    gameTimerChanged = true;
  }

  void _processGameState(bool roomState, bool audioState, bool videoState) {
    GameData gameData = super.getGame();
    // Room Status
    if(gameData.running != roomState) {
      gameData.running = roomState;
      gameStateChanged = true;
    }
    // Audio Status
    if(gameData.isAudioPlaying != audioState) {
      gameData.isAudioPlaying = audioState;
      gameStateChanged = true;
    }
    // Video Status
    if(gameData.isVideoPlaying != videoState) {
      gameData.isVideoPlaying = videoState;
      gameStateChanged = true;
    }
  }
}