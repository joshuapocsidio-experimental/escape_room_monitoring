enum RoomState{
  Ongoing,
  Ready,
  Resetting,
  RequireReset,
  Finished,
}

class RoomStateData{
  final String name;
  final String id;

  late RoomState state;
  late String stateText;
  late String timer;
  late int progress;

  RoomStateData({required this.name, required this.id, required this.state, required this.timer, required this.progress}) {
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
    }
  }
}