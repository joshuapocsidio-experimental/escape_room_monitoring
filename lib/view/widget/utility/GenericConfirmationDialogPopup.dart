import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';

class GenericConfirmationDialogPopup extends StatelessWidget {
  final String title;
  final String message;
  final Function callback;

  GenericConfirmationDialogPopup({required this.title, required this.message, required this.callback});

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: BoxConstraints.loose(MediaQuery.of(context).size/3),
      title: Text(title),
      content: Text(message),
      actions: [
        Button(
          child: const Text("Confirm"),
          onPressed: (){
            Navigator.pop(context);
            callback();
          },
          style: ButtonStyle(
            backgroundColor: ButtonState.resolveWith((states) {
              if(states.isHovering == true) return Colors.blue;
              return Colors.white;
              },
            ),
          ),
        ),
        Button(
          child: const Text("Cancel"),
          onPressed: (){
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: ButtonState.resolveWith((states) {
              if(states.isHovering == true) return const Color.fromARGB(255, 255, 100, 100);
              return Colors.white;
              },
            ),
          ),
        ),
      ],
    );
  }
}
