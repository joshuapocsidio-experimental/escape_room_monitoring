
import 'package:flutter_windows/model/stage/StageData.dart';
import 'package:flutter_windows/model/stage/StageDataHandler.dart';

class FlightStageDataHandler extends StageDataHandler{
  // Data Flags
  late bool bypassStageChanged, completedStateChanged, progressStateChanged, faultedStateChanged;
  late bool changeDetected;
  // PLC Tags
  late bool FLRM01_Puzz1_Rdy_S, FLRM01_Puzz1_Fin_S, FLRM01_Puzz1_InProg_S, FLRM01_Puzz1_Byp_S, FLRM01_Puzz1_Flt_S; // 1
  late bool FLRM01_Puzz4_Rdy_S, FLRM01_Puzz4_Fin_S, FLRM01_Puzz4_InProg_S, FLRM01_Puzz4_Byp_S, FLRM01_Puzz4_Flt_S; // 4
  late bool FLRM01_Puzz5_Rdy_S, FLRM01_Puzz5_Fin_S, FLRM01_Puzz5_InProg_S, FLRM01_Puzz5_Byp_S, FLRM01_Puzz5_Flt_S; // 5
  late bool FLRM01_Puzz6_Rdy_S, FLRM01_Puzz6_Fin_S, FLRM01_Puzz6_InProg_S, FLRM01_Puzz6_Byp_S, FLRM01_Puzz6_Flt_S; // 6
  late bool FLRM01_Puzz8_Rdy_S, FLRM01_Puzz8_Fin_S, FLRM01_Puzz8_InProg_S, FLRM01_Puzz8_Byp_S, FLRM01_Puzz8_Flt_S; // 8
  late bool FLRM01_Puzz9_Rdy_S, FLRM01_Puzz9_Fin_S, FLRM01_Puzz9_InProg_S, FLRM01_Puzz9_Byp_S, FLRM01_Puzz9_Flt_S; // 9
  late bool FLRM01_Puzz11_Rdy_S, FLRM01_Puzz11_Fin_S, FLRM01_Puzz11_InProg_S, FLRM01_Puzz11_Byp_S, FLRM01_Puzz11_Flt_S; // 11
  @override
  void readData(List<bool> digitalInputs, List<int> analogInputs) {
    // Flag resets
    bypassStageChanged = false;
    completedStateChanged = false;
    progressStateChanged = false;
    faultedStateChanged = false;
    changeDetected = false;

    // 1 - Introduction Video
    FLRM01_Puzz1_Rdy_S = digitalInputs[221];
    FLRM01_Puzz1_InProg_S = digitalInputs[222];
    FLRM01_Puzz1_Fin_S = digitalInputs[223];
    FLRM01_Puzz1_Byp_S = digitalInputs[224];
    FLRM01_Puzz1_Flt_S = digitalInputs[270];
    _processStageState(id: '01', completionState: FLRM01_Puzz1_Fin_S, inProgress: FLRM01_Puzz1_InProg_S, isBypassed: FLRM01_Puzz1_Byp_S, isFaulted: FLRM01_Puzz1_Flt_S);
    // 2 - Hidden Key (not monitored)
    // 3 - Gun Box Lock (not monitored)
    // 4 - Manual Override
    FLRM01_Puzz4_Rdy_S = digitalInputs[233];
    FLRM01_Puzz4_InProg_S = digitalInputs[234];
    FLRM01_Puzz4_Fin_S = digitalInputs[235];
    FLRM01_Puzz4_Byp_S = digitalInputs[236];
    FLRM01_Puzz4_Flt_S = digitalInputs[273];
    _processStageState(id: '04', completionState: FLRM01_Puzz4_Fin_S, inProgress: FLRM01_Puzz4_InProg_S, isBypassed: FLRM01_Puzz4_Byp_S, isFaulted: FLRM01_Puzz4_Flt_S);
    // 5 - System Override
    FLRM01_Puzz5_Rdy_S = digitalInputs[237];
    FLRM01_Puzz5_InProg_S = digitalInputs[238];
    FLRM01_Puzz5_Fin_S = digitalInputs[239];
    FLRM01_Puzz5_Byp_S = digitalInputs[240];
    FLRM01_Puzz5_Flt_S = digitalInputs[274];
    _processStageState(id: '05', completionState: FLRM01_Puzz5_Fin_S, inProgress: FLRM01_Puzz5_InProg_S, isBypassed: FLRM01_Puzz5_Byp_S, isFaulted: FLRM01_Puzz5_Flt_S);
    // 6 - Keypad Stage
    FLRM01_Puzz6_Rdy_S = digitalInputs[241];
    FLRM01_Puzz6_InProg_S = digitalInputs[242];
    FLRM01_Puzz6_Fin_S = digitalInputs[243];
    FLRM01_Puzz6_Byp_S = digitalInputs[244];
    FLRM01_Puzz6_Flt_S = digitalInputs[275];
    _processStageState(id: '06', completionState: FLRM01_Puzz6_Fin_S, inProgress: FLRM01_Puzz6_InProg_S, isBypassed: FLRM01_Puzz6_Byp_S, isFaulted: FLRM01_Puzz6_Flt_S);
    // 7 - Infrared Frame Clue (not monitored)
    // 8 - PC Login Password
    FLRM01_Puzz8_Rdy_S = digitalInputs[249];
    FLRM01_Puzz8_InProg_S = digitalInputs[250];
    FLRM01_Puzz8_Fin_S = digitalInputs[251];
    FLRM01_Puzz8_Byp_S = digitalInputs[252];
    FLRM01_Puzz8_Flt_S = digitalInputs[277];
    _processStageState(id: '08', completionState: FLRM01_Puzz8_Fin_S, inProgress: FLRM01_Puzz8_InProg_S, isBypassed: FLRM01_Puzz8_Byp_S, isFaulted: FLRM01_Puzz8_Flt_S);
    // 9 - Test Tube Antidote
    FLRM01_Puzz9_Rdy_S = digitalInputs[253];
    FLRM01_Puzz9_InProg_S = digitalInputs[254];
    FLRM01_Puzz9_Fin_S = digitalInputs[255];
    FLRM01_Puzz9_Byp_S = digitalInputs[256];
    FLRM01_Puzz9_Flt_S = digitalInputs[278];
    _processStageState(id: '09', completionState: FLRM01_Puzz9_Fin_S, inProgress: FLRM01_Puzz9_InProg_S, isBypassed: FLRM01_Puzz9_Byp_S, isFaulted: FLRM01_Puzz9_Flt_S);
    // 10 - Bravo Lock (not monitored)
    // 11 - Emergency Stage
    FLRM01_Puzz11_Rdy_S = digitalInputs[261];
    FLRM01_Puzz11_InProg_S = digitalInputs[262];
    FLRM01_Puzz11_Fin_S = digitalInputs[263];
    FLRM01_Puzz11_Byp_S = digitalInputs[264];
    FLRM01_Puzz11_Flt_S = digitalInputs[280];
    _processStageState(id: '11', completionState: FLRM01_Puzz11_Fin_S, inProgress: FLRM01_Puzz11_InProg_S, isBypassed: FLRM01_Puzz11_Byp_S, isFaulted: FLRM01_Puzz11_Flt_S);

    // Only update GUI if any data change detected
    changeDetected = bypassStageChanged || completedStateChanged || progressStateChanged;
    if(changeDetected == true) {
      super.notifyCallbacks();
    }
  }

  void _processStageState({required String id, required bool completionState, required bool inProgress, required bool isBypassed, required bool isFaulted}) {
    // Create temporary puzzle for testing : TODO ; Create a better implementation to check if puzzle state has changed
    StageData puzzle = super.stageDataMap[id]!;
    if (puzzle.isBypassed != isBypassed) {
      print("System Debug: FlightStageDataHandler - Bypass Update Detected");
      bypassStageChanged = true;
    }
    if (puzzle.isCompleted != completionState) {
      print("System Debug: FlightStageDataHandler - Completion Update Detected");
      completedStateChanged = true;
    }
    if (puzzle.inProgress != inProgress) {
      print("System Debug: FlightStageDataHandler - Progress Update Detected");
      progressStateChanged = true;
    }
    if (puzzle.isFaulted != isFaulted) {
      print("System Debug: FlightStageDataHandler - Progress Update Detected");
      faultedStateChanged = true;
    }

    if(progressStateChanged || completedStateChanged || bypassStageChanged || faultedStateChanged){
      super.stageDataMap[id]!.updateState(
        isCompleted: completionState,
        isBypassed: isBypassed,
        inProgress: inProgress,
        isFaulted: isFaulted,
      );

      for(StageData data in stageDataList)  {
        if(data.reference == id) {
          data.updateState(isCompleted: completionState, inProgress: inProgress, isBypassed: isBypassed, isFaulted: isFaulted);
        }
      }
    }
  }
}