import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/alert/AlertDataHandler.dart';
import 'AlarmDataTable.dart';

class RoomTabularAlarmCard extends StatefulWidget {
  final AlertDataHandler alertDataHandler;

  RoomTabularAlarmCard({required this.alertDataHandler});

  @override
  _RoomTabularAlarmCardState createState() => _RoomTabularAlarmCardState();
}

class _RoomTabularAlarmCardState extends State<RoomTabularAlarmCard> {
  int _currentIndex = 1;
  final radioButtons = [
    'All',
    'Active',
    'Acknowledged',
  ];

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
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Container(
              child: const Text(
                "Alerts Log",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            children: List.generate(radioButtons.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    RadioButton(
                      checked: _currentIndex == index,
                      onChanged: (bool value) {
                        setState(() {
                          _currentIndex = index;
                          widget.alertDataHandler.updateTableMode(_currentIndex);
                          print("Change To: $index");
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    Text(radioButtons[index]),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              );
            }),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Divider(),
          ),
          Expanded(
            child: AlarmDataTable(
              alertDataHandler: widget.alertDataHandler,
              tableMode: _currentIndex,
            ),
          ),
        ],
      ),
    );
  }
}
