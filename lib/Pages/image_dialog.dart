import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_studyapp/main.dart';
import 'package:fl_studyapp/timer.dart';
import 'package:provider/provider.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key});
  static show() => showDialog(
    context: navigatorKey.currentContext!,
    builder: (_) => ImageDialog(),
  );

  static var currentImage = AssetImage("assets/flower_tree.jpg");

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
        currentImage = image;
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
      title: Text("Pick a background image"),
      children: [
        imageOption("Pink flower", AssetImage("assets/image_flower.jpg")),
        imageOption("Tree at a river", AssetImage("assets/flower_tree.jpg")),
        imageOption("Waterfall", AssetImage("assets/waterfall.jpg")),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Close"),
        ),
      ],
    );
  }
}
