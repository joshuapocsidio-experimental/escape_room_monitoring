import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/hint/HintDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:flutter_windows/view/widget/room/hint/RoomHintDataTable.dart';

class RoomHintDialogPopup extends StatefulWidget {
  final BuildContext parentContext;

  RoomHintDialogPopup({required this.parentContext});

  @override
  State<RoomHintDialogPopup> createState() => _RoomHintDialogPopupState();
}

class _RoomHintDialogPopupState extends State<RoomHintDialogPopup> {
  @override
  Widget build(BuildContext context) {
    _hintDataHandler = RoomPage.of(widget.parentContext).dataHandler.hintDataHandler;
    return ContentDialog(
      constraints: BoxConstraints.loose(MediaQuery.of(context).size/3),
      title: const Text("Hint Control"),
      content: ContextMenuOverlay(child: RoomHintDataTable()),
      actions: [
        Button(child: const Text("OK"), onPressed: (){Navigator.pop(context);}),
      ],
    );
  }
}
