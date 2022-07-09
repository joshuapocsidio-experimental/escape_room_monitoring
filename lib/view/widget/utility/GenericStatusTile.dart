import 'package:fluent_ui/fluent_ui.dart';

class GenericStatusTile extends StatefulWidget {
  final String title;
  final String onStateText;
  final String offStateText;
  final bool state;


  GenericStatusTile({required this.title, required this.onStateText, required this.offStateText, required this.state});
  @override
  _GenericStatusTileState createState() => _GenericStatusTileState();
}

class _GenericStatusTileState extends State<GenericStatusTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              widget.title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 16,
          child: Text(
            widget.state == true ? widget.onStateText : widget.offStateText,
            style: TextStyle(
              color: widget.state == true ? Colors.blue : Colors.black,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
