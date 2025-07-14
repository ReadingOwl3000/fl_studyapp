import 'dart:io';
import 'package:fl_studyapp/image_picker.dart';
import 'package:fl_studyapp/shared_prefs.dart';
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
    int index,
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
      child:
          index == -1
              ? contentOfTile(title, error, image)
              : ClipRect(
                child: Dismissible(
                  key: Key(title),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    if (index != -1) {
                      setState(() {
                        MyHomePageState.imageList.removeAt(index);
                        MyHomePageState.nameOfImagesList.removeAt(index);
                        SharedPrefs().saveImages(null);
                        SharedPrefs().saveNames(null);
                      });
                    }
                  },
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.delete_rounded),
                        ),
                      ],
                    ),
                  ),
                  child: Container(child: contentOfTile(title, error, image)),
                ),
              ),
      onPressed: () {
        if (!error) {
          ImageDialog.currentImage = image;
          SharedPrefs().saveCurrentImage();
          Provider.of<StudyTimer>(
            listen: false,
            navigatorKey.currentContext!,
          ).notify();
        }
      },
    );
  }

  Widget contentOfTile(String title, bool error, ImageProvider<Object> image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
    );
  }

  Future<List<Widget>> buildWidgetList() async {
    List<Widget> list = [
      await imageOption(
        "Pink flower",
        -1,
        AssetImage("assets/image_flower.jpg"),
      ),
      await imageOption(
        "Tree at a river",
        -1,
        AssetImage("assets/flower_tree.jpg"),
      ),
      await imageOption("Waterfall", -1, AssetImage("assets/waterfall.jpg")),
      for (int i = 0; i < MyHomePageState.imageList.length; i++)
        await imageOption(
          MyHomePageState.nameOfImagesList[i],
          i,
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
                    Navigator.pop(context);
                    await ImagePicker().pick();
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
