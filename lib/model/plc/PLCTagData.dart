class PLCTagData {
  final String tag;
  final String dataType;
  final String tagAddress;
  final String description;

  PLCTagData({required this.tag, required this.dataType, required this.tagAddress, required this.description});

  @override
  String toString() {
    return tag + ", " + dataType + ", " + tagAddress + ", " + description;
  }
}