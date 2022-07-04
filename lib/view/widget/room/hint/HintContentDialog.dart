import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows/model/hint/HintDataHandler.dart';
import 'package:flutter_windows/view/screen/page/RoomPage.dart';
import 'package:flutter_windows/view/widget/room/hint/HintDataTable.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class HintContentDialog extends StatefulWidget {
  final BuildContext parentContext;

  HintContentDialog({required this.parentContext});

  @override
  State<HintContentDialog> createState() => _HintContentDialogState();
}

class _HintContentDialogState extends State<HintContentDialog> {
  late HintDataHandler _hintDataHandler;

  @override
  Widget build(BuildContext context) {
    _hintDataHandler = RoomPage.of(widget.parentContext).dataHandler.hintDataHandler;
    return ContentDialog(
      constraints: BoxConstraints.loose(MediaQuery.of(context).size/3),
      title: const Text("Hint Control"),
      content: ContextMenuOverlay(child: HintDataTable()),
      actions: [
        Button(child: const Text("OK"), onPressed: (){Navigator.pop(context);}),
      ],
    );
  }
}
