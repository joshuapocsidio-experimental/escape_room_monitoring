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
  String fileName = "$roomID\\${roomID}_equip.csv";
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
    String plcTag = equipmentEntry[6].toString().trim();
    String plcAddress = equipmentEntry[7].toString().trim();
    String plcType = equipmentEntry[8].toString().trim();
    String plcDesc = equipmentEntry[9].toString().trim();
    // Append to list
    List<String> equipParamList = [];
    equipParamList.add(equipRef);
    equipParamList.add(equipName);
    equipParamList.add(equipDesc);
    equipParamList.add(onText);
    equipParamList.add(offText);
    equipParamList.add(ref);
    equipParamList.add(plcTag);
    equipParamList.add(plcAddress);
    equipParamList.add(plcType);
    equipParamList.add(plcDesc);
    // Add to list of equipment list strings
    equipmentDataList.add(equipParamList);
  }

  return equipmentDataList;
}

Future<List<List<String>>> ExtractPuzzleDataList(String roomID) async {
  String fileName = "$roomID\\${roomID}_puzzles.csv";
  List<List<dynamic>> puzzleEntries = await ReadCSV(fileName);

  List<List<String>> puzzleDataList = [];

  // Start with 1 to ignore header line
  for(int i = 1; i < puzzleEntries.length; i++) {
    List<dynamic> puzzleEntry = puzzleEntries[i];

    // Extract parameters
    String puzzleRef = puzzleEntry[0].toString().trim().padLeft(2, '0');
    String puzzleName = puzzleEntry[1].toString().trim();
    String puzzleDesc = puzzleEntry[2].toString().trim();
    String monitored = puzzleEntry[3].toString().trim();
    // PLC Tag - Ready
    String plcRdyTag = puzzleEntry[4].toString().trim();
    String plcRdyAddress = puzzleEntry[5].toString().trim();
    String plcRdyType = puzzleEntry[6].toString().trim();
    String plcRdyDescription = puzzleEntry[7].toString().trim();
    // PLC Tag - In Progress
    String plcPrgTag = puzzleEntry[8].toString().trim();
    String plcPrgAddress = puzzleEntry[9].toString().trim();
    String plcPrgType = puzzleEntry[10].toString().trim();
    String plcPrgDescription = puzzleEntry[11].toString().trim();
    // PLC Tag - Finished
    String plcFinTag = puzzleEntry[12].toString().trim();
    String plcFinAddress = puzzleEntry[13].toString().trim();
    String plcFinType = puzzleEntry[14].toString().trim();
    String plcFinDescription = puzzleEntry[15].toString().trim();
    // PLC Tag - Bypassed
    String plcBypTag = puzzleEntry[16].toString().trim();
    String plcBypAddress = puzzleEntry[17].toString().trim();
    String plcBypType = puzzleEntry[18].toString().trim();
    String plcBypDescription = puzzleEntry[19].toString().trim();
    // Append to list
    List<String> puzzleParamList = [];
    puzzleParamList.add(puzzleRef);
    puzzleParamList.add(puzzleName);
    puzzleParamList.add(puzzleDesc);
    puzzleParamList.add(monitored);
    // PLC Ready
    puzzleParamList.add(plcRdyTag);
    puzzleParamList.add(plcRdyAddress);
    puzzleParamList.add(plcRdyType);
    puzzleParamList.add(plcRdyDescription);
    // PLC Progress
    puzzleParamList.add(plcPrgTag);
    puzzleParamList.add(plcPrgAddress);
    puzzleParamList.add(plcPrgType);
    puzzleParamList.add(plcPrgDescription);
    // PLC Finished
    puzzleParamList.add(plcFinTag);
    puzzleParamList.add(plcFinAddress);
    puzzleParamList.add(plcFinType);
    puzzleParamList.add(plcFinDescription);
    // PLC Bypassed
    puzzleParamList.add(plcBypTag);
    puzzleParamList.add(plcBypAddress);
    puzzleParamList.add(plcBypType);
    puzzleParamList.add(plcBypDescription);
    // Add to list of puzzle list strings
    puzzleDataList.add(puzzleParamList);
  }

  return puzzleDataList;
}

Future<List<List<String>>> ExtractAlertDataList(String roomID) async{
  String fileName = "$roomID\\${roomID}_alerts.csv";
  List<List<dynamic>> alertEntries = await ReadCSV(fileName);

  List<List<String>> alertDataList = [];

  // Start with 1 to ignore header line
  for(int i = 1; i < alertEntries.length; i++) {
    List<dynamic> alertEntry = alertEntries[i];

    // Extract parameters
    String alertID = alertEntry[0].toString().trim().padLeft(2, '0');
    String alertType = alertEntry[1].toString().trim();
    String alertName = alertEntry[2].toString().trim();
    String alertDesc = alertEntry[3].toString().trim();
    String alertRef = alertEntry[4].toString().trim();
    String plcTag = alertEntry[5].toString().trim();
    String plcType = alertEntry[6].toString().trim();
    String plcAddress = alertEntry[7].toString().trim();
    String plcDescription = alertEntry[8].toString().trim();
    String recommendedAction = alertEntry[9].toString().trim();

    // Append to List
    List<String> alertParamList = [];
    alertParamList.add(alertID);
    alertParamList.add(alertType);
    alertParamList.add(alertName);
    alertParamList.add(alertDesc);
    alertParamList.add(alertRef);
    alertParamList.add(plcTag);
    alertParamList.add(plcType);
    alertParamList.add(plcAddress);
    alertParamList.add(plcDescription);
    alertParamList.add(recommendedAction);
    // Add to list of alert list strings
    alertDataList.add(alertParamList);
  }

  return alertDataList;
}

Future<List<List<String>>> ExtractHintDataList(String roomID) async{
  String fileName = "$roomID\\${roomID}_hints.csv";
  List<List<dynamic>> hintEntries = await ReadCSV(fileName);

  List<List<String>> hintDataList = [];

  // Start with 1 to ignore header line
  for(int i = 1; i < hintEntries.length; i++) {
    List<dynamic> hintEntry = hintEntries[i];

    // Extract parameters
    String hintID = hintEntry[0].toString().trim().padLeft(2, '0');
    String hintTitle = hintEntry[1].toString().trim();
    String hintDesc = hintEntry[2].toString().trim();
    String hintType = hintEntry[3].toString().trim();

    // Append to List
    List<String> hintParamList = [];
    hintParamList.add(hintID);
    hintParamList.add(hintTitle);
    hintParamList.add(hintDesc);
    hintParamList.add(hintType);
    // Add to list of alert list strings
    hintDataList.add(hintParamList);
  }

  return hintDataList;
}