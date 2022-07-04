import 'package:flutter_windows/model/puzzle/PuzzleDataHandler.dart';

import '../../../model/puzzle/PuzzleData.dart';

class FlightRoomPuzzleDataHandler extends PuzzleDataHandler{
  late bool FLRM01_Puzz1_Rdy_S, FLRM01_Puzz1_Fin_S, FLRM01_Puzz1_InProg_S, FLRM01_Puzz1_Byp_S; // 1
  late bool FLRM01_Puzz4_Rdy_S, FLRM01_Puzz4_Fin_S, FLRM01_Puzz4_InProg_S, FLRM01_Puzz4_Byp_S; // 4
  late bool FLRM01_Puzz5_Rdy_S, FLRM01_Puzz5_Fin_S, FLRM01_Puzz5_InProg_S, FLRM01_Puzz5_Byp_S; // 5
  late bool FLRM01_Puzz6_Rdy_S, FLRM01_Puzz6_Fin_S, FLRM01_Puzz6_InProg_S, FLRM01_Puzz6_Byp_S; // 6
  late bool FLRM01_Puzz8_Rdy_S, FLRM01_Puzz8_Fin_S, FLRM01_Puzz8_InProg_S, FLRM01_Puzz8_Byp_S; // 8
  late bool FLRM01_Puzz9_Rdy_S, FLRM01_Puzz9_Fin_S, FLRM01_Puzz9_InProg_S, FLRM01_Puzz9_Byp_S; // 9
  late bool FLRM01_Puzz11_Rdy_S, FLRM01_Puzz11_Fin_S, FLRM01_Puzz11_InProg_S, FLRM01_Puzz11_Byp_S; // 11
  late bool changesMade;
  @override
  void updateData(List<bool> data) {
    changesMade = false;
    // 1 - Introduction Video
    FLRM01_Puzz1_Rdy_S = data[221];
    FLRM01_Puzz1_InProg_S = data[222];
    FLRM01_Puzz1_Fin_S = data[223];
    FLRM01_Puzz1_Byp_S = data[224];
    _processPuzzleState(id: '01', completionState: FLRM01_Puzz1_Fin_S, inProgress: FLRM01_Puzz1_InProg_S, isBypassed: FLRM01_Puzz1_Byp_S);
    // 2 - Hidden Key (not monitored)
    // 3 - Gun Box Lock (not monitored)
    // 4 - Manual Override
    FLRM01_Puzz4_Rdy_S = data[233];
    FLRM01_Puzz4_InProg_S = data[234];
    FLRM01_Puzz4_Fin_S = data[235];
    FLRM01_Puzz4_Byp_S = data[236];
    _processPuzzleState(id: '04', completionState: FLRM01_Puzz4_Fin_S, inProgress: FLRM01_Puzz4_InProg_S, isBypassed: FLRM01_Puzz4_Byp_S);
    // 5 - System Override
    FLRM01_Puzz5_Rdy_S = data[237];
    FLRM01_Puzz5_InProg_S = data[238];
    FLRM01_Puzz5_Fin_S = data[239];
    FLRM01_Puzz5_Byp_S = data[240];
    _processPuzzleState(id: '05', completionState: FLRM01_Puzz5_Fin_S, inProgress: FLRM01_Puzz5_InProg_S, isBypassed: FLRM01_Puzz5_Byp_S);
    // 6 - Keypad Stage
    FLRM01_Puzz6_Rdy_S = data[241];
    FLRM01_Puzz6_InProg_S = data[242];
    FLRM01_Puzz6_Fin_S = data[243];
    FLRM01_Puzz6_Byp_S = data[244];
    _processPuzzleState(id: '06', completionState: FLRM01_Puzz6_Fin_S, inProgress: FLRM01_Puzz6_InProg_S, isBypassed: FLRM01_Puzz6_Byp_S);
    // 7 - Infrared Frame Clue (not monitored)
    // 8 - PC Login Password
    FLRM01_Puzz8_Rdy_S = data[249];
    FLRM01_Puzz8_InProg_S = data[250];
    FLRM01_Puzz8_Fin_S = data[251];
    FLRM01_Puzz8_Byp_S = data[252];
    _processPuzzleState(id: '08', completionState: FLRM01_Puzz8_Fin_S, inProgress: FLRM01_Puzz8_InProg_S, isBypassed: FLRM01_Puzz8_Byp_S);
    // 9 - Test Tube Antidote
    FLRM01_Puzz9_Rdy_S = data[253];
    FLRM01_Puzz9_InProg_S = data[254];
    FLRM01_Puzz9_Fin_S = data[255];
    FLRM01_Puzz9_Byp_S = data[256];
    _processPuzzleState(id: '09', completionState: FLRM01_Puzz9_Fin_S, inProgress: FLRM01_Puzz9_InProg_S, isBypassed: FLRM01_Puzz9_Byp_S);
    // 10 - Bravo Lock (not monitored)
    // 11 - Emergency Stage
    FLRM01_Puzz11_Rdy_S = data[261];
    FLRM01_Puzz11_InProg_S = data[262];
    FLRM01_Puzz11_Fin_S = data[263];
    FLRM01_Puzz11_Byp_S = data[264];
    _processPuzzleState(id: '11', completionState: FLRM01_Puzz11_Fin_S, inProgress: FLRM01_Puzz11_InProg_S, isBypassed: FLRM01_Puzz11_Byp_S);

    // Only update GUI if any data change detected
    if(changesMade == true) {
      super.notifyCallbacks();
    }
    super.updateData(data);
    changesMade = false;
  }

  void _processPuzzleState({required String id, required bool completionState, required bool inProgress, required bool isBypassed}) {
    // Create temporary puzzle for testing : TODO ; Create a better implementation to check if puzzle state has changed
    PuzzleData puzzle = super.puzzleDataMap[id]!;
    if (puzzle.isBypassed != isBypassed) {
      print("DEBUG: Bypass Update Detected");
      changesMade = true;
    }
    if (puzzle.isCompleted != completionState) {
      print("DEBUG: Completion Update Detected");
      changesMade = true;
    }
    if (puzzle.inProgress != inProgress) {
      print("DEBUG: Progress Update Detected");
      changesMade = true;
    }
    if(changesMade){
      super.puzzleDataMap[id]!.updateState(
        isCompleted: completionState,
        isBypassed: isBypassed,
        inProgress: inProgress,
      );

      for(PuzzleData data in puzzleDataList)  {
        if(data.reference == id) {
          data.updateState(isCompleted: completionState, inProgress: inProgress, isBypassed: isBypassed);
        }
      }
    }
  }
}