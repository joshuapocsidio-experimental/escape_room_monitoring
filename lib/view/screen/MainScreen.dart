import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/screen/page/OverviewPage.dart';
import 'package:flutter_windows/view/screen/page/flight_room/FlightRoomTabularPage.dart';
import 'package:flutter_windows/view/screen/page/room_tabular/InvalidRoomTabularPage.dart';
import 'package:provider/provider.dart';

import '../../model/DataMaster.dart';
import '../../model/room/RoomData.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2;
  late ScrollController _scrollController;

  void _onNavigation(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    DataMaster master = Provider.of<DataMaster>(context);

    RoomData vaultRoomData = master.getDataHandler("tvrm01").roomDataHandler.getRoom();
    RoomData flightRoomData = master.getDataHandler("flrm01").roomDataHandler.getRoom();
    RoomData magicianRoomData = master.getDataHandler("mcrm01").roomDataHandler.getRoom();
    RoomData elevatorRoomData = master.getDataHandler("term01").roomDataHandler.getRoom();

    return NavigationView(
      appBar: buildNavigationAppBar(),
      pane: buildNavigationPane(),
      content: buildNavigationBody(
        vaultRoomData: vaultRoomData,
        flightRoomData: flightRoomData,
        magicianRoomData: magicianRoomData,
        elevatorRoomData: elevatorRoomData,
      ),
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
                icon: const Icon(FluentIcons.settings),
                onPressed: () {  },
              ),
            ],
          )
      ),
    );
  }

  Widget buildNavigationBody({required RoomData vaultRoomData, required RoomData flightRoomData, required RoomData magicianRoomData, required RoomData elevatorRoomData}) {
    return NavigationBody(
      animationDuration: Duration(milliseconds: 250),
      animationCurve: Curves.easeInOut,
      index: _currentIndex,
      children: [
        OverviewPage(),
        InvalidRoomTabularPage(roomName: "The Vault Escape Room"),
        FlightRoomTabularPage(roomID: flightRoomData.id, roomName: flightRoomData.name, maxTime: flightRoomData.maxTime),
        InvalidRoomTabularPage(roomName: "Magician's Code Escape Room"),
        InvalidRoomTabularPage(roomName: "The Elevator Escape Room"),
        InvalidRoomTabularPage(roomName: "Placeholder"),
        InvalidRoomTabularPage(roomName: "Placeholder"),
        InvalidRoomTabularPage(roomName: "Placeholder"),
        InvalidRoomTabularPage(roomName: "Placeholder"),
        InvalidRoomTabularPage(roomName: "Placeholder"),
        InvalidRoomTabularPage(roomName: "Placeholder"),
      ],
    );
  }

  NavigationPane buildNavigationPane() {
    final ScrollController _verticalScrollController = ScrollController();

    return NavigationPane(
      scrollController: _verticalScrollController,
      footerItems: [
        PaneItem(
          icon: const Icon(FluentIcons.door),
          title: const Text("Exit"),
        )
      ],
      size: NavigationPaneSize(
        openMaxWidth: MediaQuery.of(context).size.width / 7,
      ),
      selected: _currentIndex,
      displayMode: PaneDisplayMode.auto,
      onChanged: (idx){
        _onNavigation(idx);
      },
      items: [
        PaneItem(
            icon: const Icon(FluentIcons.globe),
            title: const Text("Full Overview",),
        ),
        PaneItemHeader(header: const Divider()),
        PaneItem(
            icon: const Icon(FluentIcons.room,),
            title: const Text("The Vault",),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.room),
          title: const Text("Flight 729"),
          infoBadge: const InfoBadge(source: Text("4"), color: Colors.warningPrimaryColor,)
        ),
        PaneItem(
          icon: const Icon(FluentIcons.room),
          title: const Text("Magician's Code"),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.room),
          title: const Text("The Elevator"),
        ),
        PaneItemHeader(header: const Divider()),
        PaneItem(
          icon: const Icon(FluentIcons.trending12),
          title: const Text("Trends"),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.warning),
          title: const Text("Alerts"),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.shared_notes),
          title: const Text("Handover Notes"),
        ),
        PaneItemHeader(header: const Divider()),
        PaneItem(
          icon: const Icon(FluentIcons.info12),
          title: const Text("Info Center"),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.settings),
          title: const Text("Preferences"),
        ),
      ],
    );
  }
}


