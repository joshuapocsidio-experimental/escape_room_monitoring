import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_windows/view/screen/page/OverviewPage.dart';
import 'package:flutter_windows/view/screen/page/room_tabular/ElevatorRoomTabularPage.dart';
import 'package:flutter_windows/view/screen/page/room_tabular/FlightRoomTabularPage.dart';
import 'package:flutter_windows/view/screen/page/room_tabular/MagicianRoomTabularPage.dart';
import 'package:flutter_windows/view/screen/page/room_tabular/VaultRoomTabularPage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2;
  late SliverGridDelegateWithMaxCrossAxisExtent _gridDelegate;
  late ScrollController _scrollController;

  void _onNavigation(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: buildNavigationAppBar(),
      pane: buildNavigationPane(),
      content: buildNavigationBody(),
    );
  }

  NavigationAppBar buildNavigationAppBar() {
    return NavigationAppBar(
      height: 30,
      backgroundColor: Colors.grey.withAlpha(100),
      automaticallyImplyLeading: true,
      actions: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(FluentIcons.settings),
                onPressed: () {  },
              ),
            ],
          )
      ),
    );
  }

  NavigationBody buildNavigationBody() {
    return NavigationBody(
      index: _currentIndex,
      children: [
        OverviewPage(),
        VaultRoomTabularPage(),
        FlightRoomTabularPage(),
        MagicianRoomTabularPage(),
        ElevatorRoomTabularPage(),
        ElevatorRoomTabularPage(),
        ElevatorRoomTabularPage(),
        ElevatorRoomTabularPage(),
        ElevatorRoomTabularPage(),
        ElevatorRoomTabularPage(),
        ElevatorRoomTabularPage(),
      ],
    );
  }

  NavigationPane buildNavigationPane() {
    return NavigationPane(
      footerItems: [
        PaneItem(
          icon: Icon(FluentIcons.door),
          title: Text("Exit"),
        )
      ],
      selected: _currentIndex,
      displayMode: PaneDisplayMode.auto,
      onChanged: (idx){
        _onNavigation(idx);
      },
      items: [
        PaneItem(
            icon: Icon(FluentIcons.globe),
            title: Text("Full Overview",),
            infoBadge: const InfoBadge(source: Text("10"))
        ),
        PaneItemHeader(header: Divider()),
        PaneItem(
            icon: Icon(FluentIcons.room,),
            title: Text("The Vault",),
            infoBadge: const InfoBadge(source: Text("10"))
        ),
        PaneItem(
          icon: Icon(FluentIcons.room),
          title: Text("Flight 729"),
        ),
        PaneItem(
          icon: Icon(FluentIcons.room),
          title: Text("Magician's Code"),
        ),
        PaneItem(
          icon: Icon(FluentIcons.room),
          title: Text("The Elevator"),
        ),
        PaneItemHeader(header: Divider()),
        PaneItem(
          icon: Icon(FluentIcons.trending12),
          title: Text("Trends"),
        ),
        PaneItem(
          icon: Icon(FluentIcons.warning),
          title: Text("Alerts"),
        ),
        PaneItem(
          icon: Icon(FluentIcons.shared_notes),
          title: Text("Handover Notes"),
        ),
        PaneItemHeader(header: Divider()),
        PaneItem(
          icon: Icon(FluentIcons.info12),
          title: Text("Info Center"),
        ),
        PaneItem(
          icon: Icon(FluentIcons.settings),
          title: Text("Preferences"),
        ),
      ],
    );
  }
}


