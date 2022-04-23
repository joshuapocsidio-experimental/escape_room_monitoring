import 'package:fluent_ui/fluent_ui.dart';

class ElevatorRoomTabularPage extends StatefulWidget {
  @override
  _ElevatorRoomTabularPageState createState() => _ElevatorRoomTabularPageState();
}

class _ElevatorRoomTabularPageState extends State<ElevatorRoomTabularPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(10),
      child: const Center(
        child: const Text("Elevator Room Tabular Page"),
      ),
    );
  }
}
