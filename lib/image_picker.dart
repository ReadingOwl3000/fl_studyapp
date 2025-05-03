import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fl_studyapp/main.dart';
import 'package:fl_studyapp/shared_prefs.dart';
import 'package:fl_studyapp/timer.dart';
import 'package:provider/provider.dart';

class ImagePicker {
  static late File newFile;
  Future<void> pick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      newFile = File(result.files.single.path!);
      //print(newFile);
      SharedPrefs().saveImages(result.files.single.path!);
      Provider.of<StudyTimer>(
        listen: false,
        navigatorKey.currentContext!,
      ).notify();
    } else {
      // User canceled the picker
    }
  }
}

//TODO  remove + rename images
//TODO give titles to images (list)
