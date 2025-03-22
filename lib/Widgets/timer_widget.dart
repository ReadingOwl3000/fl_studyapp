import 'package:flutter/material.dart';
import 'package:fl_studyapp/main.dart';
import 'package:provider/provider.dart';
import 'package:fl_studyapp/timer.dart';

class TimerWidget {
  static Widget buildTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    double scale = 4;
    return Column(
      children: [
        Text(
          (Provider.of<StudyTimer>(
                listen: true,
                navigatorKey.currentContext!,
              ).isFocus)
              ? "Focus Timer"
              : "Break Timer",
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(hours, textScaler: TextScaler.linear(scale)),
            Text(":", textScaler: TextScaler.linear(scale)),
            Text(minutes, textScaler: TextScaler.linear(scale)),
            Text(":", textScaler: TextScaler.linear(scale)),
            Text(seconds, textScaler: TextScaler.linear(scale)),
          ],
        ),
      ],
    );
  }
}
