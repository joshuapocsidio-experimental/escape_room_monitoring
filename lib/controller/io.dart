import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

Future<List<List<dynamic>>> ReadCSV(String fileName) async {
  final input = File('resources/${fileName}').openRead();
  List<List<dynamic>> fields = await input.transform(utf8.decoder).transform(new CsvToListConverter()).toList();

  return fields;
}

List<String> getDirectoryNames(String folderPath) {
  var directory = new Directory(folderPath);

  List<String> directoryNames = [];
  List<FileSystemEntity> directoryEntities = directory.listSync(recursive: false).toList();

  for(FileSystemEntity entity in directoryEntities){
    String dirName = entity.path.split("\\")[entity.path.split("\\").length-1].trim();
    directoryNames.add(dirName);
  }

  return directoryNames;
}

Future<Map<String, String>> ExtractRoomInfo(String roomID) async {
  String fileName = "${roomID}\\${roomID}_info.csv";
  List<List<dynamic>> infoList = await ReadCSV(fileName);

  Map<String, String> infoMap = {};

  // Start with 1 to ignore header line
  for(int i = 1; i < infoList.length; i++) {
    List<dynamic> infoEntry = infoList[i];

    String parameter = infoEntry[0].toString();
    String value = infoEntry[1].toString();

    infoMap[parameter] = value;
  }

  print(infoMap);

  return infoMap;
}

Future<List<List<String>>> ExtractEquipmentDataList(String roomID) async {
  String fileName = "${roomID}\\${roomID}_equip.csv";
  List<List<dynamic>> equipmentEntries = await ReadCSV(fileName);

  List<List<String>> equipmentDataList = [];

  // Start with 1 to ignore header line
  for(int i = 1; i < equipmentEntries.length; i++) {
    List<dynamic> equipmentEntry = equipmentEntries[i];

    // Extract parameters
    String equipRef = equipmentEntry[0].toString().trim();
    String equipName = equipmentEntry[1].toString().trim();
    String equipDesc = equipmentEntry[2].toString().trim();
    String onText = equipmentEntry[3].toString().trim();
    String offText = equipmentEntry[4].toString().trim();
    String ref = equipmentEntry[5].toString().trim();
    // Append to list
    List<String> equipParamList = [];
    equipParamList.add(equipRef);
    equipParamList.add(equipName);
    equipParamList.add(equipDesc);
    equipParamList.add(onText);
    equipParamList.add(offText);
    equipParamList.add(ref);
    // Add to list of equipment list strings
    equipmentDataList.add(equipParamList);
  }

  return equipmentDataList;
}

Future<List<List<String>>> ExtractPuzzleDataList(String roomID) async {
  String fileName = "${roomID}\\${roomID}_puzzles.csv";
  List<List<dynamic>> puzzleEntries = await ReadCSV(fileName);

  List<List<String>> puzzleDataList = [];

  // Start with 1 to ignore header line
  for(int i = 1; i < puzzleEntries.length; i++) {
    List<dynamic> puzzleEntry = puzzleEntries[i];

    // Extract parameters
    String puzzleRef = puzzleEntry[0].toString().trim();
    String puzzleName = puzzleEntry[1].toString().trim();
    String puzzleDesc = puzzleEntry[2].toString().trim();
    String monitored = puzzleEntry[3].toString().trim();

    // Append to list
    List<String> equipParamList = [];
    equipParamList.add(puzzleRef);
    equipParamList.add(puzzleName);
    equipParamList.add(puzzleDesc);
    equipParamList.add(monitored);
    // Add to list of equipment list strings
    puzzleDataList.add(equipParamList);
  }

  return puzzleDataList;
}