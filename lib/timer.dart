import 'package:flutter/material.dart';
import 'dart:async';

import 'Pages/end_dialog.dart';
import 'Wigets/timer_widget.dart';

class StudyTimer extends ChangeNotifier {
  Timer? timer;
  static Duration timerDuration = Duration(
    seconds: 5,
  ); //change duration here! or possibly durationNotifier.value

  final ValueNotifier<Duration> durationNotifier = ValueNotifier<Duration>(
    timerDuration,
  );

  void runTimer(context) {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime(context));
    TimerWidget().buildTime(timerDuration);
    durationNotifier.value = timerDuration;
  }

  void addTime(context) {
    final seconds = durationNotifier.value.inSeconds - 1;
    if (seconds < 0) {
      timer?.cancel();
      EndDialog.show(context);
    } else {
      durationNotifier.value = Duration(seconds: seconds);
      notifyListeners();
    }
  }
}
