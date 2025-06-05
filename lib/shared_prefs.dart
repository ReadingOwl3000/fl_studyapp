import 'package:fl_studyapp/main.dart';
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

  Future<void> saveImages(newImage) async {
    final prefs = await SharedPreferences.getInstance();
    MyHomePageState.imageList = prefs.getStringList("images") ?? [];
    MyHomePageState.imageList.add(newImage);
    prefs.setStringList("images", MyHomePageState.imageList);
  }

  Future<List<String>> getImages() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("images") ?? [];
  }

  Future<List<String>> getNames() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("names") ?? [];
  }

  Future<void> saveNames(newImageName) async {
    final prefs = await SharedPreferences.getInstance();
    MyHomePageState.nameOfImagesList = prefs.getStringList("names") ?? [];
    MyHomePageState.nameOfImagesList.add(newImageName);
    prefs.setStringList("names", MyHomePageState.nameOfImagesList);
  }
}
