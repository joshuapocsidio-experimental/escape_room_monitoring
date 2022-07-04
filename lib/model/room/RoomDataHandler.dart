import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/DataObserver.dart';
import 'package:flutter_windows/model/room/MediaData.dart';

import 'RoomData.dart';

class RoomDataHandler extends DataObserver{
  late RoomData _roomData;
  final List<Function> callbacks = [];

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

  void addCallback(Function callback){
    if(callbacks.contains(callback) == false){
      this.callbacks.add(callback);
    }
  }

  void notifyCallbacks(){
    for(Function callback in callbacks){
      callback();
    }
  }
  /// INITIAL
  RoomData createRoom(String ip, String id, String maxTime, String name){
    // Validate Time
    if(maxTime.contains(":") == false) print("Invalid Time"); // TODO: Throw Exception
    // Extract Media and Audio Data TODO: Add audio and video data onto data files for information extraction

    return RoomData(ip: ip, id: id, maxTime: maxTime, name: name);
  }


  @override
  void updateData(List<bool> data) {
//    print("Room Data - Update Data callback");
    super.updateData(data);
  }
}