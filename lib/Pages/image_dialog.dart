import 'dart:io';

import 'package:fl_studyapp/image_picker.dart';
//import 'package:fl_studyapp/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:fl_studyapp/main.dart';
import 'package:fl_studyapp/timer.dart';
import 'package:provider/provider.dart';

class ImageDialog extends StatefulWidget {
  const ImageDialog({super.key});
  static show() => showDialog(
    context: navigatorKey.currentContext!,
    builder: (_) => ImageDialog(),
  );

  static ImageProvider currentImage = AssetImage("assets/flower_tree.jpg");

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  Widget imageOption(title, image) {
    return SimpleDialogOption(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              image: DecorationImage(image: image, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
      onPressed: () {
        ImageDialog.currentImage = image;
        Provider.of<StudyTimer>(
          listen: false,
          navigatorKey.currentContext!,
        ).notify();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Pick a background image"),
          IconButton(
            onPressed: () async {
              await ImagePicker().pick();
              setState(() {});
            },
            icon: Icon(Icons.add_a_photo_outlined),
          ),
        ],
      ),
      children: [
        imageOption("Pink flower", AssetImage("assets/image_flower.jpg")),
        imageOption("Tree at a river", AssetImage("assets/flower_tree.jpg")),
        imageOption("Waterfall", AssetImage("assets/waterfall.jpg")),
        for (int i = 0; i < MyHomePageState.imageList.length; i++)
          imageOption(
            "from files",
            FileImage(File(MyHomePageState.imageList[i])),
          ),

        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Close"),
        ),
      ],
    );
  }
}
