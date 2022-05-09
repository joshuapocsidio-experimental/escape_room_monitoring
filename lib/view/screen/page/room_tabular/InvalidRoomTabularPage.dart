import 'package:fluent_ui/fluent_ui.dart';

class InvalidRoomTabularPage extends StatelessWidget {
  final String roomName;

  InvalidRoomTabularPage({required String this.roomName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Cannot find $roomName configuration files."),
      ),
    );
  }
}
