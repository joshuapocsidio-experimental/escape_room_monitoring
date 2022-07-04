import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/room/control/RoomTabularControlCard.dart';
import 'package:flutter_windows/view/widget/room/hint/HintTabularCard.dart';
import '../../../widget/room/game/GameStateCard.dart';
import '../../../widget/room/alert/RoomTabularAlarmCard.dart';
import '../../../widget/room/summary/RoomTabularSummaryCard.dart';

class FlightRoomTabularPage extends StatefulWidget {
  final String roomName;
  final String roomID;
  final String maxTime;

  FlightRoomTabularPage({required this.roomName, required this.roomID, required this.maxTime});

  @override
  _FlightRoomTabularPageState createState() => _FlightRoomTabularPageState();
}

class _FlightRoomTabularPageState extends State<FlightRoomTabularPage> {
  int _controlTabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void updateControlTabIndex(int index) {
    setState(() {
      _controlTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(30),
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 4, right: 4),
                        child: RoomTabularSummaryCard(),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 4, right: 4),
                          child: TabView(
                            closeButtonVisibility: CloseButtonVisibilityMode.never,
                            onChanged: updateControlTabIndex,
                            tabs: const [
                              Tab(
                                text: Text('Hints Panel'),
                                icon: Icon(FluentIcons.hint_text),
                              ),
                              Tab(
                                text: Text('Game Log'),
                                icon: Icon(FluentIcons.game),
                              ),
                              Tab(
                                text: Text('Control Log'),
                                icon: Icon(FluentIcons.admin_c_logo_inverse32),
                              ),
                            ],
                            bodies: [
                              HintTabularCard(),
                              HintTabularCard(),
                              RoomTabularControlCard(),
                            ],
                            currentIndex: _controlTabIndex,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, top: 8, bottom: 8, right: 8),
                    child: GameStateCard(
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 8, right: 4),
              child:
              RoomTabularAlarmCard(),
            ),
          ),
        ],
      ),
    );
  }
}
