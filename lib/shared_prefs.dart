import 'package:shared_preferences/shared_preferences.dart';
import 'timer.dart';

class SharedPrefs {
  Future<void> writePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    StudyTimer.focusDuration.inSeconds;
    prefs.setInt("break", StudyTimer.breakDuration.inSeconds);
    prefs.setInt("focus", StudyTimer.focusDuration.inSeconds);
  }

  Future<void> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    StudyTimer.breakDuration = Duration(seconds: prefs.getInt("break") ?? 600);
    StudyTimer.focusDuration = Duration(seconds: prefs.getInt("focus") ?? 1200);
  }
}
