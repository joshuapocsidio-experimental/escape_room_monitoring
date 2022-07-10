import 'package:fluent_ui/fluent_ui.dart';

class GenericCommandBarButton extends CommandBarButton {
  final IconData iconData;
  final String text;
  final Function callback;

  GenericCommandBarButton({required this.iconData, required this.text, required this.callback}) : super(icon: Icon(iconData), onPressed: () {callback();}) {

  }

}