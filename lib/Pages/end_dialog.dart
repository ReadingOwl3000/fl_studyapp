//import 'package:fl_studyapp/main.dart';
import 'package:fl_studyapp/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_studyapp/main.dart';

class EndDialog extends StatelessWidget {
  const EndDialog({super.key});
  static show(BuildContext context) => showDialog(
    context: navigatorKey.currentContext!,
    builder: (_) => EndDialog(),
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Timer Ended"),
      content: const Text("The timer has ended."),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text("Restart"),
              onPressed: () {
                Provider.of<StudyTimer>(
                  listen: false,
                  context,
                ).runTimer(context);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
