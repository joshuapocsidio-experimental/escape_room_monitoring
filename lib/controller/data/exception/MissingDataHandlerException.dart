class MissingDataHandlerException implements Exception{
  final String message;

  MissingDataHandlerException({required this.message});

  @override
  String toString() {
    return message;
  }
}