//import 'package:fl_studyapp/main.dart';
import 'package:fl_studyapp/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_studyapp/main.dart';

class EndDialog extends StatelessWidget {
  const EndDialog({super.key});
  static show() => showDialog(
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
                Provider.of<StudyTimer>(listen: false, context).runTimer();
                Navigator.of(context).pop();
              },
            ),
            otherTimerButton(
              Provider.of<StudyTimer>(listen: false, context),
              context,
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

  Widget otherTimerButton(studyTimer, context) {
    if (studyTimer.isFocus) {
      return TextButton(
        child: const Text("Start break"),
        onPressed: () {
          StudyTimer.timerDuration = StudyTimer.breakDuration;
          studyTimer.isFocus = false;
          studyTimer.runTimer();
          studyTimer.notify();
          Navigator.of(context).pop();
        },
      );
    } else {
      return TextButton(
        child: const Text("Start focus"),
        onPressed: () {
          StudyTimer.timerDuration = StudyTimer.focusDuration;
          studyTimer.isFocus = true;
          studyTimer.notify();
          studyTimer.runTimer();
          Navigator.of(context).pop();
        },
      );
    }
  }
}
