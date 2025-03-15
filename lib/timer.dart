import 'package:flutter/material.dart';
import 'dart:async';

import 'Pages/end_dialog.dart';
import 'Widgets/timer_widget.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class StudyTimer extends ChangeNotifier {
  Timer? timer;
  static Duration timerDuration = Duration(
    minutes: 20,
  ); //change duration here! or possibly durationNotifier.value
  bool isPlaying = false;
  bool toResume = false;
  final ValueNotifier<Duration> durationNotifier = ValueNotifier<Duration>(
    timerDuration,
  );

  void runTimer() {
    TimerWidget.buildTime(timerDuration);
    isPlaying = true;
    WakelockPlus.enable();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    if (toResume) {
      toResume = false;
    } else {
      durationNotifier.value = timerDuration;
    }
  }

  void addTime() {
    final seconds = durationNotifier.value.inSeconds - 1;
    if (seconds < 0) {
      timer?.cancel();
      isPlaying = false;
      durationNotifier.value = timerDuration;
      notify();
      WakelockPlus.disable();
      EndDialog.show();
    } else {
      durationNotifier.value = Duration(seconds: seconds);
      notifyListeners();
    }
  }

  void pauseTimer() {
    isPlaying = false;
    toResume = true;
    timer?.cancel();
    notify();
  }

  void notify() {
    notifyListeners();
  }
}
