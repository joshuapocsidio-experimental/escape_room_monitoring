import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_windows/handlers/io.dart';
import 'package:flutter_windows/view/screen/MainScreen.dart';
import 'package:provider/provider.dart';

import 'handlers/RoomStateHandler.dart';

void main() async {
//  print(await ExtractRoomInfo("flrm01"));
  Map<String, String> roomInfoMap = await ExtractRoomInfo("flrm01");
  RoomStateHandler roomStateHandler = RoomStateHandler();
  roomStateHandler.parseRoom(roomInfoMap);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: roomStateHandler,
        )
      ],
      child: WinApp(),
    )
  );
}

class WinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.blue,
        inactiveColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        navigationPaneTheme: NavigationPaneThemeData(
          animationDuration: const Duration(milliseconds: 100),
          highlightColor: Colors.orange.resolveFromReverseBrightness(
            Brightness.light,
            level: Brightness.light.isDark ? 2 : 0,
          ),
          selectedIconColor: ButtonState.all(
            Colors.blue,
          ),
          unselectedIconColor: ButtonState.all(
            Colors.black,
          ),
          iconPadding: const EdgeInsets.all(8),
          selectedTextStyle: ButtonState.all(
            const TextStyle(
              fontSize: 20,
              color: Colors.black
            ),
          ),
          unselectedTextStyle: ButtonState.all(
            const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          itemHeaderTextStyle: const TextStyle(
            fontSize: 30,
            color: Colors.black,
          )
        ),
      ),
      home: const MainScreen(),
    );
  }
}

