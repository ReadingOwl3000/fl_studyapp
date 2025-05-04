import 'dart:io';
import 'package:fl_studyapp/image_picker.dart';
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
  Future<Widget> imageOption(
    String title,
    ImageProvider image, {
    filepath,
  }) async {
    bool error = false;
    if (filepath != null) {
      if (!(await File(filepath).exists())) {
        error = true;
      }
    }
    return SimpleDialogOption(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              image:
                  error
                      ? null
                      : DecorationImage(image: image, fit: BoxFit.contain),
            ),
            child: error ? Text("error: image not found") : SizedBox.shrink(),
          ),
        ],
      ),
      onPressed: () {
        if (!error) {
          ImageDialog.currentImage = image;
          Provider.of<StudyTimer>(
            listen: false,
            navigatorKey.currentContext!,
          ).notify();
        }
      },
    );
  }

  Future<List<Widget>> buildWidgetList() async {
    List<Widget> list = [
      await imageOption("Pink flower", AssetImage("assets/image_flower.jpg")),
      await imageOption(
        "Tree at a river",
        AssetImage("assets/flower_tree.jpg"),
      ),
      await imageOption("Waterfall", AssetImage("assets/waterfall.jpg")),
      for (int i = 0; i < MyHomePageState.imageList.length; i++)
        await imageOption(
          "from files",
          FileImage(File(MyHomePageState.imageList[i])),
          filepath: MyHomePageState.imageList[i],
        ),
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text("Close"),
      ),
    ];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: buildWidgetList(), // Call the Future method
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
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
                  icon: const Icon(Icons.add_a_photo_outlined),
                ),
              ],
            ),
            children: snapshot.data ?? [], // Use the data from the Future
          );
        }
      },
    );
  }
}
