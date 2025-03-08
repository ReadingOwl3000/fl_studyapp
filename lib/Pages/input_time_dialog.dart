import 'package:fl_studyapp/timer.dart';
import 'package:flutter/material.dart';
import 'package:fl_studyapp/main.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class InputTimeDialog extends StatelessWidget {
  const InputTimeDialog({super.key});
  static show() => showDialog(
    context: navigatorKey.currentContext!,
    builder: (_) => InputTimeDialog(),
  );

  @override
  Widget build(BuildContext context) {
    var minutesController = TextEditingController(
      text:
          "${Provider.of<StudyTimer>(listen: true, context).durationNotifier.value.inMinutes}",
    );
    var secondsOutput = Provider.of<StudyTimer>(
      listen: true,
      context,
    ).durationNotifier.value.toString().substring(5, 7);
    var secondsController = TextEditingController(text: "$secondsOutput");
    return Dialog(
      child: SizedBox(
        height: 300,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("How long would you like to focus?"),

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
                StudyTimer.timerDuration = Duration(
                  minutes: int.parse(minutesController.text),
                  seconds: int.parse(secondsController.text),
                );
                Provider.of<StudyTimer>(listen: false, context)
                    .durationNotifier
                    .value = StudyTimer.timerDuration;
                print(
                  Provider.of<StudyTimer>(
                    listen: false,
                    context,
                  ).durationNotifier.value,
                );
                print(StudyTimer.timerDuration);
                Provider.of<StudyTimer>(listen: false, context).notify();
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
