import 'package:fluent_ui/fluent_ui.dart';

class MagicianRoomTabularPage extends StatefulWidget {
  @override
  _MagicianRoomTabularPageState createState() => _MagicianRoomTabularPageState();
}

class _MagicianRoomTabularPageState extends State<MagicianRoomTabularPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(10),
      child: const Center(
        child: const Text("Magician Room Tabular Page"),
      ),
    );
  }
}
