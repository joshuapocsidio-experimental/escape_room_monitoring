import 'package:flutter_windows/controller/data/ModbusHandler.dart';
import 'package:flutter_windows/model/DataHandler.dart';
import 'package:flutter_windows/model/game/GameDataController.dart';
import 'package:flutter_windows/model/room/GameData.dart';

class FlightGameController extends GameDataController {
  final MBHandler modbusHandler;
  FlightGameController({required GameData gameData, required this.modbusHandler, required String ip})
      : super(gameData: gameData, modbusHandler: modbusHandler, ip:ip);
  
  @override
  void startGame(){
    super.sendCommand(0, true);
  }

  @override
  void stopGame() {
    super.sendCommand(1, true);
  }

  @override
  void resetGame (){
    super.sendCommand(2, true);
  }
  
  // Timer
  void startTimer() {
    
  }
  
  void stopTimer() {
    
  }
  
  void resetTimer() {
    
  }
  
  void addTimer() {
    
  }
  
  void subtractTimer() {
    
  }
}