import 'package:fluent_ui/fluent_ui.dart';

enum AlertType{
  Warning,
  Attention,
  Alarm,
  Info,
}

class AlertData{
  final AlertType type;
  final String title;
  final String description;
  final int reference;

  late Color color;
  late String alertText;

  AlertData({required this.type, required this.title, required this.description, required this.reference}){
    switch(type){
      case AlertType.Warning:
        this.color = Colors.orange;
        this.alertText = "Warning";
        break;
      case AlertType.Attention:
        this.color = Colors.red;
        this.alertText = "Attention";
        break;
      case AlertType.Alarm:
        this.color = Colors.red;
        this.alertText = "Alarm";
        break;
      case AlertType.Info:
        this.color = Colors.blue;
        this.alertText = "Info";
        break;
    }
  }
}
