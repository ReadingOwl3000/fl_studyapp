import 'dart:io';

import 'package:fl_studyapp/Pages/image_dialog.dart';
import 'package:fl_studyapp/main.dart';
import 'package:flutter/cupertino.dart';
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

  Future<void> saveImages(String? newImage) async {
    final prefs = await SharedPreferences.getInstance();
    if (newImage != null) {
      MyHomePageState.imageList.add(newImage);
    }
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

  Future<void> saveNames(String? newImageName) async {
    final prefs = await SharedPreferences.getInstance();
    if (newImageName != null) {
      MyHomePageState.nameOfImagesList.add(newImageName);
    }
    prefs.setStringList("names", MyHomePageState.nameOfImagesList);
  }

  Future<void> renameImage(String newName, int placeInList) async {
    final prefs = await SharedPreferences.getInstance();
    MyHomePageState.nameOfImagesList.replaceRange(
      placeInList,
      placeInList + 1,
      [newName],
    );
    prefs.setStringList("names", MyHomePageState.nameOfImagesList);
  }

  Future<void> saveCurrentImage(String filepath) async {
    final prefs = await SharedPreferences.getInstance();
    String image = "";
    if (!filepath.startsWith("ignorethis/assets/")) {
      image = 'FileImage "$filepath"';
    } else {
      String path = filepath.replaceFirst("ignorethis/", "");
      image = 'AssetImage "$path"';
    }
    prefs.setString("currentImage", image);
  }

  Future<ImageProvider> getCurrentImage() async {
    final prefs = await SharedPreferences.getInstance();
    String imageString = prefs.getString("currentImage") ?? "none";
    late ImageProvider image;
    if (imageString.startsWith("AssetImage")) {
      String name = getName(imageString);
      image = AssetImage(name);
    } else if (imageString.startsWith("FileImage")) {
      File file = File(getName(imageString));
      if (await file.exists()) {
        image = FileImage(file);
      } else {
        image = AssetImage("assets/flower_tree.jpg");
      }
    } else {
      image = AssetImage("assets/flower_tree.jpg");
    }
    return image;
  }

  String getName(String imageString) {
    String name = imageString.substring(
      imageString.indexOf('"'),
      imageString.lastIndexOf('"'),
    );
    name = name.replaceFirst('"', '');
    return name;
  }
}
