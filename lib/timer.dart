import 'package:flutter/material.dart';
import 'dart:async';

import 'Pages/end_dialog.dart';
import 'Wigets/timer_widget.dart';

class StudyTimer extends ChangeNotifier {
  Timer? timer;
  static Duration timerDuration = Duration(
    minutes: 20,
  ); //change duration here! or possibly durationNotifier.value

  final ValueNotifier<Duration> durationNotifier = ValueNotifier<Duration>(
    timerDuration,
  );

  void runTimer() {
    TimerWidget().buildTime(timerDuration);
    notify(); //this is so it also shows the first second after a restart and not 00
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    TimerWidget().buildTime(durationNotifier.value);
    durationNotifier.value = timerDuration;
  }

  void addTime() {
    final seconds = durationNotifier.value.inSeconds - 1;
    if (seconds < 0) {
      timer?.cancel();
      EndDialog.show();
    } else {
      durationNotifier.value = Duration(seconds: seconds);
      notifyListeners();
    }
  }

  void notify() {
    notifyListeners();
  }
}
