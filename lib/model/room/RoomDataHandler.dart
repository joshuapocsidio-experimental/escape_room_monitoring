import 'package:fluent_ui/fluent_ui.dart';

import 'RoomData.dart';

class RoomDataHandler{
  late RoomData _roomData;

  void addRoom(Map<String,String> infoMap){
    String ip, roomID, roomName, maxTime;

    ip = infoMap["ip"] ?? "N/A";
    roomID = infoMap["roomID"] ?? "N/A";
    roomName = infoMap["roomName"] ?? "N/A";
    maxTime = infoMap["maxMin"] ?? "N/A";

    RoomData newRoom = createRoom(ip, roomID, maxTime, roomName); // TODO: Catch Error
    _roomData = newRoom;
  }

  RoomData getRoom(){
    if(_roomData == null) {
      print("Room Data has not been initialized."); // TODO: Throw Exception
    }
    return _roomData;
  }

  /// INITIAL
  RoomData createRoom(String ip, String id, String maxTime, String name){
    // Validate Time
    if(maxTime.contains(":") == false) print("Invalid Time"); // TODO: Throw Exception

    return RoomData(ip: ip, id: id, maxTime: maxTime, name: name);
  }
}