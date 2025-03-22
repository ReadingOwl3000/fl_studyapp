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

    if (isFocus) {
      descriptiveText = "How long would you like to focus?";
    } else {
      descriptiveText = "How long would you like your break?";
    }

    // String descriptiveText = "How long would you like to focus?";
    var minutesController = TextEditingController(
      text:
          "${Provider.of<StudyTimer>(listen: false, context).durationNotifier.value.inMinutes}",
    );
    var secondsOutput = Provider.of<StudyTimer>(
      listen: false,
      context,
    ).durationNotifier.value.toString().substring(5, 7);
    var secondsController = TextEditingController(text: secondsOutput);
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
                var newDuration =
                    StudyTimer.focusDuration = Duration(
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
