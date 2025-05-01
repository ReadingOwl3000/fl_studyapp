import 'package:fl_studyapp/timer.dart';
import 'package:flutter/material.dart';
import 'package:fl_studyapp/main.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class InputTimeDialog extends StatelessWidget {
  const InputTimeDialog(this.isFocus, {super.key});
  static show(isFocus) => showDialog(
    context: navigatorKey.currentContext!,
    builder: (_) => InputTimeDialog(isFocus),
  );
  final bool isFocus;

  @override
  Widget build(BuildContext context) {
    // bool isFocus = true;
    String descriptiveText;
    String hintTextMinutes;
    String hintTextSeconds;

    if (isFocus) {
      descriptiveText = "How long would you like to focus?";
      hintTextMinutes = StudyTimer.focusDuration.inMinutes.toString();
      hintTextSeconds = StudyTimer.focusDuration.toString().substring(5, 7);
    } else {
      descriptiveText = "How long would you like your break?";
      hintTextMinutes = StudyTimer.breakDuration.inMinutes.toString();
      hintTextSeconds = StudyTimer.breakDuration.toString().substring(5, 7);
    }

    var minutesController = TextEditingController(text: hintTextMinutes);
    var secondsController = TextEditingController(text: hintTextSeconds);
    return Dialog(
      child: SizedBox(
        height: 300,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(descriptiveText),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: minutesController,
                  ),
                ),
                Text("Minutes"),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: secondsController,
                  ),
                ),
                Text("Seconds"),
              ],
            ),
            TextButton(
              onPressed: () {
                var studyTimer = Provider.of<StudyTimer>(
                  listen: false,
                  context,
                );
                var newDuration = Duration(
                  minutes: int.parse(minutesController.text),
                  seconds: int.parse(secondsController.text),
                );
                if (isFocus) {
                  StudyTimer.focusDuration = newDuration;
                  StudyTimer.timerDuration = StudyTimer.focusDuration;
                  studyTimer.durationNotifier.value = StudyTimer.focusDuration;
                  studyTimer.isFocus = true;
                  studyTimer.notify();
                  Navigator.pop(context);
                } else {
                  // break timer logic here
                  StudyTimer.breakDuration = newDuration;
                  StudyTimer.timerDuration = StudyTimer.breakDuration;

                  studyTimer.durationNotifier.value = StudyTimer.timerDuration;
                  studyTimer.isFocus = false;
                  studyTimer.notify();
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
