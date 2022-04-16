import 'package:fluent_ui/fluent_ui.dart';

class ElevatorRoomPhysicalPage extends StatefulWidget {
  @override
  _ElevatorRoomPhysicalPageState createState() => _ElevatorRoomPhysicalPageState();
}

class _ElevatorRoomPhysicalPageState extends State<ElevatorRoomPhysicalPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(10),
      child: Center(
        child: Text("Elevator Room Physical Page"),
      ),
    );
  }
}
