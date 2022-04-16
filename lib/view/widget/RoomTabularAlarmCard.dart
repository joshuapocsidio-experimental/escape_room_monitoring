import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/AlarmDataTable.dart';

class RoomTabularAlarmCard extends StatefulWidget {
  @override
  _RoomTabularAlarmCardState createState() => _RoomTabularAlarmCardState();
}

class _RoomTabularAlarmCardState extends State<RoomTabularAlarmCard> {


  @override
  Widget build(BuildContext context) {
    return Acrylic(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      luminosityAlpha: 0,
      tintAlpha: 0,
      blurAmount: 500,
      elevation: 20,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(),
          ),
          Container(
            child: Text(
              "Alerts Log",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(),
          ),
          Expanded(child: AlarmDataTable()),
        ],
      ),
    );
  }
}
