import 'package:flutter_windows/model/DataNotifier.dart';

import 'GameData.dart';

abstract class GameDataHandler extends DataNotifier{
  // Update Data
  void readData(List<bool> digitalInputs, List<int> analogInputs);
  // Specific room game data
  late GameData _gameData;

  void addGame(Map<String,String> infoMap){
    String ip, roomID, roomName, maxTime;

    ip = infoMap["ip"] ?? "N/A";
    roomID = infoMap["roomID"] ?? "N/A";
    roomName = infoMap["roomName"] ?? "N/A";
    maxTime = infoMap["maxMin"] ?? "N/A";

    GameData newRoom = createGame(ip, roomID, maxTime, roomName); // TODO: Catch Error
    _gameData = newRoom;
  }

  GameData getGame(){
    if(_gameData == null) {
      print("Room Data has not been initialized."); // TODO: Throw Exception
    }
    return _gameData;
  }

  /// INITIAL
  GameData createGame(String ip, String id, String maxTime, String name){
    // Validate Time
    if(maxTime.contains(":") == false) print("Invalid Time"); // TODO: Throw Exception
    // Extract Media and Audio Data TODO: Add audio and video data onto data files for information extraction

    return GameData(ip: ip, id: id, maxTime: maxTime, name: name);
  }
}