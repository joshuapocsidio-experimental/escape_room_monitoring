import 'package:flutter_windows/model/room/RoomData.dart';
import 'package:flutter_windows/model/room/RoomDataHandler.dart';

class FlightRoomSummaryDataHandler extends RoomDataHandler {
  late bool changesMade;
  List<bool> roomStates = List.filled(10, false);
  // Game Running Status
  late bool FLRM01_GameRnng_S;
  // Media Playing Status
  late bool FLRM01_RPI01_AudRnng_S, FLRM01_RPI01_VidRnng_S;


  @override
  void updateData(List<bool> data) {
    changesMade = false;
    FLRM01_GameRnng_S = data[201];
    FLRM01_RPI01_AudRnng_S = data[354];
    FLRM01_RPI01_VidRnng_S = data[362];
    _processRoomState(FLRM01_GameRnng_S, FLRM01_RPI01_AudRnng_S, FLRM01_RPI01_VidRnng_S);

    // Only update GUI if any data change detected
    if(changesMade == true) {
      super.notifyCallbacks();
    }
    super.updateData(data);
  }

  void _processRoomState(bool roomState, bool audioState, bool videoState) {
    RoomData roomData = super.getRoom();
    // Room Status
    if(roomData.running != roomState) {
      roomData.running = roomState;
      changesMade = true;
    }
    // Audio Status
    if(roomData.isAudioPlaying != audioState) {
      roomData.isAudioPlaying = audioState;
      changesMade = true;
    }
    // Video Status
    if(roomData.isVideoPlaying != videoState) {
      roomData.isVideoPlaying = videoState;
      changesMade = true;
    }
  }
}