import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/alert/AlertDataHandler.dart';
import 'package:flutter_windows/view/screen/page/OverviewPage.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:flutter_windows/view/screen/page/room/ElevatorRoomPage.dart';
import 'package:flutter_windows/view/screen/page/room/FlightRoomPage.dart';
import 'package:flutter_windows/view/screen/page/room/InvalidRoomPage.dart';
import 'package:flutter_windows/view/screen/page/room/MagicianRoomPage.dart';
import 'package:flutter_windows/view/screen/page/room/VaultRoomPage.dart';
import 'package:provider/provider.dart';

import '../../controller/data/exception/MissingDataHandlerException.dart';
import '../../model/DataMaster.dart';
import '../../model/room/GameData.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2;
  late ScrollController _scrollController;
  late NavigationHandler navHandler;

  void _onNavigation(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  void _refreshState() {
    setState(() {
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    navHandler = NavigationHandler();
    navHandler.addCallback(_onNavigation);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    DataMaster dataMaster = Provider.of<DataMaster>(context);
    dataMaster.getDataHandler('flrm01').alertDataHandler.addCallback(_refreshState);

    NavigationPane navPane = buildNavigationPane(dataMaster: dataMaster);

    return NavigationView(
      appBar: buildNavigationAppBar(),
      pane: navPane,
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

    GameData vaultGameData;
    GameData flightGameData;
    GameData magicianGameData;
    GameData elevatorGameData;

    navigationWidgets.add(OverviewPage());

    // The Vault Escape Room
    try{
      vaultGameData = dataMaster.getDataHandler("tvrm01").gameDataHandler.getGame();
      navigationWidgets.add(VaultRoomPage(roomID: vaultGameData.id, roomName: vaultGameData.name, maxTime: vaultGameData.maxTime));
    }
    on MissingDataHandlerException catch (e) {
//      print(e.message);
      navigationWidgets.add(InvalidRoomPage(roomName: "The Vault Escape Room"));
    }
    // Flight Room Escape Room
    try{
      flightGameData = dataMaster.getDataHandler("flrm01").gameDataHandler.getGame();
      // navigationWidgets.add(InvalidRoomTabularPage(roomName: "Flight 729 Escape Room"));
      navigationWidgets.add(
        RoomPage(
            dataHandler: dataMaster.getDataHandler('flrm01'),
            child: FlightRoomPage(roomID: flightGameData.id, roomName: flightGameData.name, maxTime: flightGameData.maxTime),
        ),
      );
    }
    on MissingDataHandlerException catch (e) {
//      print(e.message);
      navigationWidgets.add(InvalidRoomPage(roomName: "Flight 729 Escape Room"));
    }
    // Magician's Code Escape Room
    try{
      magicianGameData = dataMaster.getDataHandler("mcrm01").gameDataHandler.getGame();
      navigationWidgets.add(MagicianRoomPage(roomID: magicianGameData.id, roomName: magicianGameData.name, maxTime: magicianGameData.maxTime));
    }
    on MissingDataHandlerException catch (e) {
//      print(e.message);
      navigationWidgets.add(InvalidRoomPage(roomName: "Magician's Code Escape Room"));
    }
    // The Elevator Escape Room
    try{
      elevatorGameData = dataMaster.getDataHandler("term01").gameDataHandler.getGame();
      navigationWidgets.add(ElevatorRoomPage(roomID: elevatorGameData.id, roomName: elevatorGameData.name, maxTime: elevatorGameData.maxTime));
    }
    on MissingDataHandlerException catch (e) {
//      print(e.message);
      navigationWidgets.add(InvalidRoomPage(roomName: "The Elevator Escape Room"));
    }

    navigationWidgets.add(InvalidRoomPage(roomName: "Placeholder")); // Trends
//    navigationWidgets.add(AlarmDataTable(tableMode: 1, alertDataHandler: dataMaster.getDataHandler('flrm01').alertDataHandler,));
    navigationWidgets.add(InvalidRoomPage(roomName: "Placeholder")); // Alerts
    navigationWidgets.add(InvalidRoomPage(roomName: "Placeholder")); // Handover Notes
    navigationWidgets.add(InvalidRoomPage(roomName: "Placeholder")); // Info Center
    navigationWidgets.add(InvalidRoomPage(roomName: "Placeholder")); // Preferences
    navigationWidgets.add(InvalidRoomPage(roomName: "Placeholder")); // Exit

    return Provider.value(
      value: navHandler,
      child: NavigationBody(
        animationDuration: Duration(milliseconds: 250),
        animationCurve: Curves.easeInOut,
        index: _currentIndex,
        children: navigationWidgets,
      ),
    );
  }


  NavigationPane buildNavigationPane({required DataMaster dataMaster}) {
    final ScrollController _verticalScrollController = ScrollController();
    AlertDataHandler flightAlertDataHandler = dataMaster.getDataHandler('flrm01').alertDataHandler;
    int flightNumAlerts = flightAlertDataHandler.activeAlertList.length;
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
          infoBadge: flightNumAlerts != 0 ?
          InfoBadge(source: Text(flightNumAlerts.toString()), color: Colors.warningPrimaryColor,) :
          InfoBadge(source: Text(""), color: Colors.transparent,)
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

class NavigationHandler {
  List<Function> callbacks = [];

  void navigate(String roomID) {
    switch(roomID) {
      case 'flrm01':
        notifyListeners(2);
        break;
    }
  }

  void addCallback(Function function) {
    callbacks.add(function);
  }

  void notifyListeners(int index) {
    for(Function callback in callbacks) {
      callback(index);
    }
  }

}

class RoomNavigationPane extends NavigationPane {

}

