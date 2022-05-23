import 'package:fluent_ui/fluent_ui.dart';
import '../../../controller/data/exception/MissingDataHandlerException.dart';
import 'package:flutter_windows/model/DataHandler.dart';
import 'package:flutter_windows/model/DataMaster.dart';
import 'package:flutter_windows/model/puzzle/PuzzleDataHandler.dart';
import '../../widget/room/overview/RoomOverviewCard.dart';
import 'package:provider/provider.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  final List<Widget> overviewCards = [];

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataMaster dataMaster = Provider.of<DataMaster>(context);

    // The Vault Data Handler
    try{
      DataHandler vaultDataHandler = dataMaster.getDataHandler("tvrm01");
      overviewCards.add(RoomOverviewCard(roomName: "The Vault", puzzleDataHandler: vaultDataHandler.puzzleDataHandler, equipmentDataHandler: vaultDataHandler.equipmentDataHandler,));
    }
    on MissingDataHandlerException catch(e){
      print(e.message);
    }
    // Flight 729 Data Handler
    try{
      DataHandler flightDataHandler = dataMaster.getDataHandler("flrm01");
      overviewCards.add(RoomOverviewCard(roomName: "Flight 729", puzzleDataHandler: flightDataHandler.puzzleDataHandler, equipmentDataHandler: flightDataHandler.equipmentDataHandler,));
    }
    on MissingDataHandlerException catch(e){
      print(e.message);
    }
    // Magician's Code Data Handler
    try{
      DataHandler magicianDataHandler = dataMaster.getDataHandler("mcrm01");
      overviewCards.add(RoomOverviewCard(roomName: "Magician's Code", puzzleDataHandler: magicianDataHandler.puzzleDataHandler, equipmentDataHandler: magicianDataHandler.equipmentDataHandler,));
    }
    on MissingDataHandlerException catch(e){
      print(e.message);
    }
    // The Elevator Data Handler
    try{
      DataHandler elevatorDataHandler = dataMaster.getDataHandler("term01");
      overviewCards.add(RoomOverviewCard(roomName: "The Elevator", puzzleDataHandler: elevatorDataHandler.puzzleDataHandler, equipmentDataHandler: elevatorDataHandler.equipmentDataHandler,));
    }
    on MissingDataHandlerException catch(e){
      print(e.message);
    }

    // Equipment Data Handlers
    return Container(
      color: const Color.fromARGB(100, 147, 147, 147),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: overviewCards,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2540/1440,
        ),
      ),
    );
  }
}
