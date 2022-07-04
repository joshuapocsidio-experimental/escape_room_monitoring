import 'package:fluent_ui/fluent_ui.dart';

class OperatorControlCard extends StatefulWidget {
  @override
  _OperatorControlCardState createState() => _OperatorControlCardState();
}

class _OperatorControlCardState extends State<OperatorControlCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CommandBar(
            mainAxisAlignment: MainAxisAlignment.center,
            primaryItems: [
              CommandBarButton(
                icon: Icon(FluentIcons.play),
                onPressed: () {

                },
              ),
              CommandBarButton(
                icon: Icon(FluentIcons.pause),
                onPressed: () {

                },
              ),
              CommandBarButton(
                icon: Icon(FluentIcons.stop),
                onPressed: () {

                },
              ),
              CommandBarButton(
                icon: Icon(FluentIcons.play_resume),
                onPressed: () {

                },
              ),
              CommandBarButton(
                icon: Icon(FluentIcons.reset),
                onPressed: () {

                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
