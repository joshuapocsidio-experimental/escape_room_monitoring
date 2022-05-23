import 'package:flutter_windows/model/alert/AlertData.dart';

class AttentionAlert extends AlertData{
  AttentionAlert({required String time, required AlertType type, required String title, required String description, required String reference}) : super(time: time, type: type, title: title, description: description, reference: reference);

}