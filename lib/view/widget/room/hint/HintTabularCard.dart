import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/hint/HintDataHandler.dart';
import 'package:flutter_windows/view/widget/room/hint/HintDataTable.dart';

import '../../../screen/page/RoomPage.dart';

class HintTabularCard extends StatefulWidget {
  @override
  _HintTabularCardState createState() => _HintTabularCardState();
}

class _HintTabularCardState extends State<HintTabularCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: const Text(
              "Hints Panel",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ContextMenuOverlay(
              child: HintDataTable(),
            ),
          ),
        ],
      ),
    );
  }
}
