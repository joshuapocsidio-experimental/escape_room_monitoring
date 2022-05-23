import 'package:fluent_ui/fluent_ui.dart';
import '../controller/data/exception/MissingDataHandlerException.dart';
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
    if(_dataHandlerMap.containsKey(id) == false) {
      throw MissingDataHandlerException(message: "MissingDataHandlerException : Data Handler '$id' does not exist.");
    }

    return _dataHandlerMap[id]!;
  }

  List<DataHandler> getDataHandlerList(){
    return List.unmodifiable(_dataHandlerList);
  }
}