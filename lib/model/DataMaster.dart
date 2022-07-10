import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/DataController.dart';
import 'package:flutter_windows/model/DataControllerManager.dart';
import '../controller/data/exception/MissingDataHandlerException.dart';
import 'package:flutter_windows/model/DataHandler.dart';

class DataMaster with ChangeNotifier{
  late final List<DataHandler> _dataHandlerList;
  late final Map<String, DataHandler> _dataHandlerMap;
  late final List<DataControllerManager> _dataControllerManagerList;
  late final Map<String, DataControllerManager> _dataControllerManagerMap;

  DataMaster(){
    _dataHandlerList = [];
    _dataHandlerMap = {};

    _dataControllerManagerList = [];
    _dataControllerManagerMap = {};
  }

  void addDataHandler(String id, DataHandler dataHandler){
    if(_dataHandlerMap.containsKey(id)){
      print("Data Handler already exists."); // TODO: Throw Exception
      return;
    }
    _dataHandlerList.add(dataHandler);
    _dataHandlerMap[id] = dataHandler;
  }

  void addDataControllerManager(String id, DataControllerManager dataControllerManager) {
    if(_dataControllerManagerMap.containsKey(id)) {
      print("Data Controller already exists."); // TODO: Throw Exception
      return;
    }
    _dataControllerManagerList.add(dataControllerManager);
    _dataControllerManagerMap[id] = dataControllerManager;
  }

  DataHandler getDataHandler(String id){
    if(_dataHandlerMap.containsKey(id) == false) {
      throw MissingDataHandlerException(message: "MissingDataHandlerException : Data Handler '$id' does not exist.");
    }

    return _dataHandlerMap[id]!;
  }

  List<DataHandler> getDataHandlerList(){
    return List.unmodifiable(_dataHandlerList);
  }

  DataControllerManager getDataControllerManager(String id) {
    if(_dataControllerManagerMap.containsKey(id) == false) {
      // TODO Throw exception
    }
    return _dataControllerManagerMap[id]!;
  }

  List<DataControllerManager> getDataControllerManagerList(){
    return List.unmodifiable(_dataControllerManagerList);
  }
}