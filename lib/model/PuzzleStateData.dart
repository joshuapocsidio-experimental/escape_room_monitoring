import 'package:fluent_ui/fluent_ui.dart';

enum PuzzleState {
  Completed,
  Attempted,
  NotAttempted,
  InProgress,
}

class PuzzleStateData{
  final int reference;
  final String name;
  final String description;
  final PuzzleState state;

  late Color color;
  late String stateText;

  PuzzleStateData({required this.reference, required this.name, required this.description, required this.state}) {
    switch(this.state){
      case PuzzleState.Completed:
        this.color = Colors.green;
        this.stateText = "Completed";
        break;
      case PuzzleState.Attempted:
        this.color = Colors.orange;
        this.stateText = "Attempted";
        break;
      case PuzzleState.NotAttempted:
        this.color = Colors.grey;
        this.stateText = "Not Attempted";
        break;
      case PuzzleState.InProgress:
        this.color = Colors.blue;
        this.stateText = "In Progress";
        break;
    }

  }


}