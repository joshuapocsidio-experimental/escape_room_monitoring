import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/DataMaster.dart';
import 'package:provider/provider.dart';

import '../../../controller/data/exception/MissingDataHandlerException.dart';
import '../../widget/room/overview/SiteOverviewCard.dart';

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
      overviewCards.add(SiteOverviewCard(dataHandler: dataMaster.getDataHandler('tvrm01'),));
    }
    on MissingDataHandlerException catch(e){
      print(e.message);
    }
    // Flight 729 Data Handler
    try{
      overviewCards.add(SiteOverviewCard(dataHandler: dataMaster.getDataHandler('flrm01'),));
    }
    on MissingDataHandlerException catch(e){
      print(e.message);
    }
    // Magician's Code Data Handler
    try{
      overviewCards.add(SiteOverviewCard(dataHandler: dataMaster.getDataHandler('mcrm01'),));
    }
    on MissingDataHandlerException catch(e){
      print(e.message);
    }
    // The Elevator Data Handler
    try{
      overviewCards.add(SiteOverviewCard(dataHandler: dataMaster.getDataHandler('term01'),));
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
