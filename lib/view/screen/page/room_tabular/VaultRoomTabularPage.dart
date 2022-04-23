import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';

class VaultRoomTabularPage extends StatefulWidget {
  @override
  _VaultRoomTabularPageState createState() => _VaultRoomTabularPageState();
}

class _VaultRoomTabularPageState extends State<VaultRoomTabularPage> {
  String _text = "Vault Room Tabular Page";

  void _test(){
    var pixelRatio = window.devicePixelRatio;
    var physicalSize, physicalWidth, physicalHeight;
    var logicalSize, logicalWidth, logicalHeight;
    var safeSize, safeWidth, safeHeight;

    physicalSize = window.physicalSize;
    physicalWidth = physicalSize.width;
    physicalHeight = physicalSize.height;

    logicalSize = MediaQuery.of(context).size;
    logicalWidth = logicalSize.width;
    logicalHeight = logicalSize.height;

    var safeTop = MediaQuery.of(context).padding.top;
    var safeLeft = MediaQuery.of(context).padding.left;
    var safeRight = MediaQuery.of(context).padding.right;
    var safeBottom = MediaQuery.of(context).padding.bottom;

    safeWidth = logicalWidth - safeLeft - safeRight;
    safeHeight = logicalHeight - safeTop - safeBottom;

    setState(() {
      _text = "Physical: " + physicalSize.toString() + " : " + physicalWidth.toString() + "," + physicalHeight.toString() + "\n";
      _text = _text + "Logical: " + logicalSize.toString() + " : " + logicalWidth.toString() + "," + logicalHeight.toString() + "\n";
      _text = _text + "Safe: " + safeWidth.toString() + "," + safeHeight.toString() + "\n";
    });
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.grey.withAlpha(10),
      child: Center(
        child: Button(
            onPressed: _test,
            child: Text(_text)),
      ),
    );
  }
}
