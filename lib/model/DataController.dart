import 'dart:async';

import 'package:flutter_windows/controller/data/ModbusHandler.dart';
import 'package:flutter_windows/model/DataNotifier.dart';
import 'package:flutter_windows/model/game/GameDataController.dart';

abstract class DataController extends DataNotifier{
  final MBHandler mbHandler;
  final String ip;

  DataController({required this.mbHandler, required this.ip});

  // Send Commands - These are typically one-shot type and should reset after 1x scan time
  void sendCommand(int address, bool state) {
    print("Command Send");
    var connectionMap = mbHandler.connectionMap;
    String ipAddress = ip;
    connectionMap[ipAddress]!.write(address, state);
    // Wait for a full scan rate - then invert
    Timer(Duration(milliseconds: mbHandler.pollRate), (){
      connectionMap[ipAddress]!.write(address, !state);
    });
  }
}