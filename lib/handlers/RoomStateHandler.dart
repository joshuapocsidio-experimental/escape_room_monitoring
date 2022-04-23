import 'package:fluent_ui/fluent_ui.dart';

import '../model/RoomStateData.dart';

class RoomStateHandler with ChangeNotifier{
  final List<RoomStateData> rooms = [];

  void parseRoom(Map<String,String> infoMap){
    String ip, roomID, roomName, maxTime;

    ip = infoMap["ip"] ?? "N/A";
    roomID = infoMap["roomID"] ?? "N/A";
    roomName = infoMap["roomName"] ?? "N/A";
    maxTime = infoMap["maxMin"] ?? "N/A";

    createRoom(ip, roomID, roomName, maxTime);
  }

  void createRoom(String ip, String roomID, String roomName, String maxTime){
    rooms.add(new RoomStateData(ip: ip, id: roomID, name: roomName, maxTime: maxTime));
  }
}