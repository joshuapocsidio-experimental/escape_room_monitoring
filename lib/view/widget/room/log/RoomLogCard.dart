
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/game/GameControlDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:flutter_windows/view/widget/room/hint/RoomHintCard.dart';
import 'package:flutter_windows/view/widget/room/log/gameControl/GameControlLogCard.dart';
import 'package:flutter_windows/view/widget/room/log/gameEvent/GameEventLogCard.dart';

class RoomLogCard extends StatefulWidget {
  @override
  _RoomLogCardState createState() => _RoomLogCardState();
}

class _RoomLogCardState extends State<RoomLogCard> {
  late GameControlDataHandler gameControlDataHandler;

  int _controlTabIndex = 0;
  void updateControlTabIndex(int index) {
    setState(() {
      _controlTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    gameControlDataHandler = RoomPage.of(context).dataHandler.gameControlDataHandler;
    return TabView(
      closeButtonVisibility: CloseButtonVisibilityMode.never,
      onChanged: updateControlTabIndex,
      tabs: const [
        Tab(
          text: Text('Hints Panel'),
          icon: Icon(FluentIcons.hint_text),
        ),
        Tab(
          text: Text('Game Events Log'),
          icon: Icon(FluentIcons.game),
        ),
        Tab(
          text: Text('Game Control Log'),
          icon: Icon(FluentIcons.admin_c_logo_inverse32),
        ),
      ],
      bodies: [
        RoomHintCard(),
        GameEventLogCard(),
        GameControlLogCard(),
      ],
      currentIndex: _controlTabIndex,
    );
  }
}
