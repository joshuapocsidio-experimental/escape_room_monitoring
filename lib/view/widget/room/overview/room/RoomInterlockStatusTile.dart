import 'package:fluent_ui/fluent_ui.dart';

class RoomInterlockStatusTile extends StatelessWidget {
  final String healthyTitle;
  final String unhealthyTitle;
  final bool healthyState;

  RoomInterlockStatusTile({required this.healthyTitle, required this.unhealthyTitle, required this.healthyState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: healthyState == false ? const Color.fromARGB(255, 255, 100, 100) : Colors.grey.withAlpha(50),
              shape: BoxShape.circle,
            ),
            child: Icon(
              FluentIcons.circle_ring,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(healthyState == true ? healthyTitle : unhealthyTitle),
          ),
        ],
      ),
    );
  }
}
