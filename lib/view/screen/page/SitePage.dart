import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/DataController.dart';
import 'package:flutter_windows/model/DataControllerManager.dart';
import 'package:flutter_windows/model/DataHandler.dart';

class SitePage extends InheritedWidget {
  final DataHandler dataHandler;
  SitePage({required Widget child, required this.dataHandler, required this.dataControllerManager}) : super(child: child);

  final DataControllerManager dataControllerManager;

  @override
  bool updateShouldNotify(SitePage oldWidget) {
    return dataHandler != oldWidget.dataHandler || dataControllerManager != oldWidget.dataControllerManager;
  }

  static SitePage of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SitePage>()!;
  }
}