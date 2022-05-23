import 'package:fluent_ui/fluent_ui.dart';
import '../../controller/data/exception/MissingDataHandlerException.dart';
import 'package:flutter_windows/view/screen/page/OverviewPage.dart';
import 'package:flutter_windows/view/screen/page/elevator_room/ElevatorRoomTabularPage.dart';
import 'package:flutter_windows/view/screen/page/flight_room/FlightRoomTabularPage.dart';
import 'package:flutter_windows/view/screen/page/room_tabular/InvalidRoomTabularPage.dart';
import 'package:flutter_windows/view/screen/page/room_tabular/MagicianRoomTabularPage.dart';
import 'package:flutter_windows/view/screen/page/room_tabular/VaultRoomTabularPage.dart';
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
    DataMaster dataMaster = Provider.of<DataMaster>(context);

    return NavigationView(
      appBar: buildNavigationAppBar(),
      pane: buildNavigationPane(),
      content: buildNavigationBody(
        dataMaster: dataMaster,
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

  Widget buildNavigationBody({required DataMaster dataMaster}) {
    List<Widget> navigationWidgets = [];

    RoomData vaultRoomData;
    RoomData flightRoomData;
    RoomData magicianRoomData;
    RoomData elevatorRoomData;

    navigationWidgets.add(OverviewPage());

    // The Vault Escape Room
    try{
      vaultRoomData = dataMaster.getDataHandler("tvrm01").roomDataHandler.getRoom();
      navigationWidgets.add(VaultRoomTabularPage(roomID: vaultRoomData.id, roomName: vaultRoomData.name, maxTime: vaultRoomData.maxTime));
    }
    on MissingDataHandlerException catch (e) {
      print(e.message);
      navigationWidgets.add(InvalidRoomTabularPage(roomName: "The Vault Escape Room"));
    }
    // Flight Room Escape Room
    try{
      flightRoomData = dataMaster.getDataHandler("flrm01").roomDataHandler.getRoom();
      navigationWidgets.add(FlightRoomTabularPage(roomID: flightRoomData.id, roomName: flightRoomData.name, maxTime: flightRoomData.maxTime));
    }
    on MissingDataHandlerException catch (e) {
      print(e.message);
      navigationWidgets.add(InvalidRoomTabularPage(roomName: "Flight 729 Escape Room"));
    }
    // Magician's Code Escape Room
    try{
      magicianRoomData = dataMaster.getDataHandler("mcrm01").roomDataHandler.getRoom();
      navigationWidgets.add(MagicianRoomTabularPage(roomID: magicianRoomData.id, roomName: magicianRoomData.name, maxTime: magicianRoomData.maxTime));
    }
    on MissingDataHandlerException catch (e) {
      print(e.message);
      navigationWidgets.add(InvalidRoomTabularPage(roomName: "Magician's Code Escape Room"));
    }
    // The Elevator Escape Room
    try{
      elevatorRoomData = dataMaster.getDataHandler("term01").roomDataHandler.getRoom();
      navigationWidgets.add(ElevatorRoomTabularPage(roomID: elevatorRoomData.id, roomName: elevatorRoomData.name, maxTime: elevatorRoomData.maxTime));
    }
    on MissingDataHandlerException catch (e) {
      print(e.message);
      navigationWidgets.add(InvalidRoomTabularPage(roomName: "The Elevator Escape Room"));
    }

    navigationWidgets.add(InvalidRoomTabularPage(roomName: "Placeholder")); // Trends
    navigationWidgets.add(InvalidRoomTabularPage(roomName: "Placeholder")); // Alerts
    navigationWidgets.add(InvalidRoomTabularPage(roomName: "Placeholder")); // Handover Notes
    navigationWidgets.add(InvalidRoomTabularPage(roomName: "Placeholder")); // Info Center
    navigationWidgets.add(InvalidRoomTabularPage(roomName: "Placeholder")); // Preferences
    navigationWidgets.add(InvalidRoomTabularPage(roomName: "Placeholder")); // Exit

    return NavigationBody(
      animationDuration: Duration(milliseconds: 250),
      animationCurve: Curves.easeInOut,
      index: _currentIndex,
      children: navigationWidgets,
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


