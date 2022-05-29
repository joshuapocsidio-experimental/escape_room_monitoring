class InvalidAlertTypeException implements Exception {
  final String message;

  InvalidAlertTypeException({required this.message});

  @override
  String toString() {
    return message;
  }
}