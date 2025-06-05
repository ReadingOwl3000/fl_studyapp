import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fl_studyapp/Pages/image_name_dialog.dart';
import 'package:fl_studyapp/shared_prefs.dart';

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
      ImageNameDialog.show();
    } else {
      // User canceled the picker
    }
  }
}

//TODO  remove + rename images
