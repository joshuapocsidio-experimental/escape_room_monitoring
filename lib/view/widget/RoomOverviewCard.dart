import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/view/widget/RoomOverviewGridView.dart';
import 'package:flutter_windows/view/widget/RoomOverviewStageCard.dart';

class RoomOverviewCard extends StatefulWidget {
  late String roomName;

  RoomOverviewCard({required this.roomName});

  @override
  _RoomOverviewCardState createState() => _RoomOverviewCardState();
}

class _RoomOverviewCardState extends State<RoomOverviewCard> {
  @override
  Widget build(BuildContext context) {
    return Acrylic(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      luminosityAlpha: 1,
      tintAlpha: 50,
      blurAmount: 10,
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.withAlpha(80),
              child: ListTile(
                leading: Text("48:00"),
                title: Center(child: Text(widget.roomName, textAlign: TextAlign.center)),
                trailing: Row(
                  children: [
                    IconButton(icon: Icon(FluentIcons.ringer), onPressed: (){},),
                    IconButton(icon: Icon(FluentIcons.more), onPressed: (){},),
                  ],
                )
              ),
            ),
          ),
          Expanded(
            flex: 17,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                color: Colors.white,
                child: RoomOverviewGridView()
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("70%"),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ProgressBar(
                      value: 70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
