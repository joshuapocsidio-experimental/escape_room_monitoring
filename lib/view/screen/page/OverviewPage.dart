import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/RoomOverviewCard.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  List<Widget> overviewCards = [
    RoomOverviewCard(roomName: "The Vault"),
    RoomOverviewCard(roomName: "Flight 729"),
    RoomOverviewCard(roomName: "Magician's Code"),
    RoomOverviewCard(roomName: "The Elevator"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(100, 147, 147, 147),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: overviewCards,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2540/1440,
        ),
      ),
    );
  }
}
