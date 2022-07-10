import 'package:flutter_windows/model/room/GameData.dart';
import 'package:flutter_windows/model/room/GameDataHandler.dart';

class FlightRoomGameDataHandler extends GameDataHandler {
  // Data Flags
  late bool gameStateChanged, gameTimerChanged;
  late bool changeDetected;

  int currSec = 0, currMin = 0;
  List<bool> roomStates = List.filled(10, false);
  // Game Running Status
  late bool FLRM01_GameRnng_S, FLRM01_GameFin_S, FLRM01_GameStp_S;
  late bool FLRM01_GameRdy_S, FLRM01_EquipRdy_S, FLRM01_StagesRdy_S;
  late bool FLRM01_StagesOK_S, FLRM01_EquipOK_S;
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
    FLRM01_GameRdy_S = digitalInputs[200];
    FLRM01_GameFin_S = digitalInputs[204];
    FLRM01_GameStp_S = digitalInputs[202];
    FLRM01_EquipRdy_S = digitalInputs[300];
    FLRM01_EquipOK_S = digitalInputs[301];
    FLRM01_StagesRdy_S = digitalInputs[220];
    FLRM01_StagesOK_S = digitalInputs[269];


    FLRM01_RPI01_AudRnng_S = digitalInputs[354];
    FLRM01_RPI01_VidRnng_S = digitalInputs[362];
    _processGameState(
      gameReady: FLRM01_GameRdy_S,
      equipReady: FLRM01_EquipRdy_S,
      stagesReady: FLRM01_StagesRdy_S,
      runningState: FLRM01_GameRnng_S,
      audioState: FLRM01_RPI01_AudRnng_S,
      videoState: FLRM01_RPI01_VidRnng_S,
      equipOK: FLRM01_EquipOK_S,
      stagesOK: FLRM01_StagesOK_S,
      gameFinished: FLRM01_GameFin_S,
      gameStopped: FLRM01_GameStp_S,
    );

    // Analog Data
    FLRM01_TmrDispMin_N = analogInputs[20];
    FLRM01_TmrDispSec_N = analogInputs[21];
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

  void _processGameState({required bool gameReady, required bool equipReady, required bool stagesReady,
    required bool runningState, required bool audioState, required bool videoState,
    required bool equipOK, required bool stagesOK,
    required bool gameFinished, required bool gameStopped,
  }) {
    GameData gameData = super.getGame();
    // Game Ready Status
    if(gameData.gameReady != gameReady) {
      gameData.gameReady = gameReady;
      gameStateChanged = true;
    }
    // Equipment Ready Status
    if(gameData.equipmentReady != equipReady) {
      gameData.equipmentReady = equipReady;
      gameStateChanged = true;
    }
    // Equipment OK Status
    if(gameData.equipmentHealthy != equipOK) {
      gameData.equipmentHealthy = equipOK;
      gameStateChanged = true;
    }
    // Stages Ready Status
    if(gameData.stagesReady != stagesReady) {
      gameData.stagesReady = stagesReady;
      gameStateChanged = true;
    }
    // Stages OK Status
    if(gameData.stagesHealthy != stagesOK) {
      gameData.stagesHealthy = stagesOK;
      gameStateChanged = true;
    }
    // Game Running Status
    if(gameData.running != runningState) {
      gameData.running = runningState;
      gameStateChanged = true;
    }
    // Game Finished Status
    if(gameData.gameFinished != gameFinished) {
      gameData.gameFinished = gameFinished;
      gameStateChanged = true;
    }
    // Game Stopped Status
    if(gameData.gameStandby != gameStopped) {
      gameData.gameStandby = gameStopped;
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

    gameData.updateState();
  }
}