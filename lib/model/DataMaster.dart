import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/DataHandler.dart';

class DataMaster with ChangeNotifier{
  late final List<DataHandler> _dataHandlerList;
  late final Map<String, DataHandler> _dataHandlerMap;

  DataMaster(){
    _dataHandlerList = [];
    _dataHandlerMap = {};
  }

  void addDataHandler(String id, DataHandler dataHandler){
    if(_dataHandlerMap.containsKey(id)){
      print("Data Handler already exists."); // TODO: Throw Exception
      return;
    }
    _dataHandlerList.add(dataHandler);
    _dataHandlerMap[id] = dataHandler;
  }

  DataHandler getDataHandler(String id){
    print("DEBUG ID: " + id);
    if(_dataHandlerMap.containsKey(id) == false) {
      print("Handler does not exist."); // TODO: Throw Exception
    }

    return _dataHandlerMap[id]!;
  }
}