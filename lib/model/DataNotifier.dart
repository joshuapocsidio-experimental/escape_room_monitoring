
abstract class DataNotifier{
  final List<Function> callbacks = [];

  // Add Callback
  void addCallback(Function callback){
    if(callbacks.contains(callback) == false){
      callbacks.add(callback);
    }
  }
  // Remove Callback
  void removeCallback(Function callback) {
    callbacks.remove(callback);
  }
  // Call all callbacks
  void notifyCallbacks(){
    for(Function callback in callbacks){
      callback();
    }
  }
}