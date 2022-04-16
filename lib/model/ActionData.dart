enum ActionType{
  Game,
  Hint,
  Bypass,
  Timer,
}

class ActionData{
  final String description;
  final int reference;
  final String time;
  final ActionType type;

  late String actionString;

  ActionData({required this.description, required this.reference, required this.time, required this.type}){
    switch(type){
      case ActionType.Game:
        this.actionString = "Game Control";
        break;
      case ActionType.Hint:
        this.actionString = "Hint Control";
        break;
      case ActionType.Bypass:
        this.actionString = "Bypass Control";
        break;
      case ActionType.Timer:
        this.actionString = "Timer Control";
        break;
    }
  }
}
