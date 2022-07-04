import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/DataHandler.dart';

class RoomPage extends InheritedWidget {
  final DataHandler dataHandler;

  RoomPage({required Widget child, required this.dataHandler}) : super(child: child);

  @override
  bool updateShouldNotify(RoomPage oldWidget) {
    return dataHandler != oldWidget.dataHandler;
  }

  static RoomPage of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RoomPage>()!;
  }
}