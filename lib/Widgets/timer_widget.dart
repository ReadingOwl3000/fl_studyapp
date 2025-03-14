import 'package:flutter/material.dart';

class TimerWidget {
  Widget buildTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    double scale = 4;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(hours, textScaler: TextScaler.linear(scale)),
        Text(":", textScaler: TextScaler.linear(scale)),
        Text(minutes, textScaler: TextScaler.linear(scale)),
        Text(":", textScaler: TextScaler.linear(scale)),
        Text(seconds, textScaler: TextScaler.linear(scale)),
      ],
    );
  }
}
