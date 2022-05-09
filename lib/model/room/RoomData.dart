import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum RoomState{
  Ongoing,
  Ready,
  Resetting,
  RequireReset,
  Finished,
  Disconnected,
}

class RoomData{
  final String name;
  final String id;
  final String ip;

  late RoomState state;
  late String stateText;
  late String maxTime;
  late String remTime;
  late String curTime;
  late int progress;

  RoomData({required this.name, required this.id, required this.ip, required this.maxTime}) {
    this.state = RoomState.Disconnected;
    this.stateText = "Disconnected";
    this.remTime = maxTime;
    this.curTime = '00:00';
    this.progress = 0;
  }

  void checkState() {
    switch(state){
      case RoomState.Ongoing:
        this.stateText = "Ongoing";
        break;
      case RoomState.Ready:
        this.stateText = "Ready";
        break;
      case RoomState.Resetting:
        this.stateText = "Resetting";
        break;
      case RoomState.RequireReset:
        this.stateText = "Requires Reset";
        break;
      case RoomState.Finished:
        this.stateText = "Finished";
        break;
      case RoomState.Disconnected:
        this.stateText = "Disconnected";
        break;
    }
  }
}


