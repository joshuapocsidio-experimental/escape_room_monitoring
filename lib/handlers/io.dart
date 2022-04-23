import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

Future<List<List<dynamic>>> ReadCSV(String fileName) async {
  final input = File('resources/${fileName}').openRead();
  List<List<dynamic>> fields = await input.transform(utf8.decoder).transform(new CsvToListConverter()).toList();

  return fields;
}

Future<Map<String, String>> ExtractRoomInfo(String roomID) async {
  String fileName = "${roomID}_info.csv";
  List<List<dynamic>> infoList = await ReadCSV(fileName);

  Map<String, String> infoMap = {};

  for(int i = 1; i < infoList.length; i++) {
    List<dynamic> infoEntry = infoList[i];

    String parameter = infoEntry[0];
    String value = infoEntry[1].toString();

    infoMap[parameter] = value;
  }

  return infoMap;
}