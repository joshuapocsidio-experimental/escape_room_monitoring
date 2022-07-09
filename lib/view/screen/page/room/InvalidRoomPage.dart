import 'package:fluent_ui/fluent_ui.dart';

class InvalidRoomPage extends StatelessWidget {
  final String roomName;

  InvalidRoomPage({required String this.roomName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Cannot find $roomName configuration files."),
      ),
    );
  }
}
