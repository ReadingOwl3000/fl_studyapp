import 'package:fl_studyapp/Pages/image_dialog.dart';
import 'package:fl_studyapp/main.dart';
import 'package:fl_studyapp/shared_prefs.dart';
import 'package:fl_studyapp/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageNameDialog extends StatelessWidget {
  const ImageNameDialog(this.isRename, this.placeInList, {super.key});
  static show({bool isRename = false, int placeInList = -1}) => {
    if ((isRename && placeInList != -1) || !isRename)
      {
        showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) => ImageNameDialog(isRename, placeInList),
        ),
      },
  };
  final bool isRename;
  final int placeInList;
  static TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 200,
      child: SimpleDialog(
        title: const Text("Please name this image"),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: TextField(
                      onSubmitted: (value) {
                        onSubmitted(context, isRename, placeInList);
                      },
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "image name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed:
                        () => onSubmitted(context, isRename, placeInList),
                    child: Text("Apply"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onSubmitted(context, bool isRename, int placeInList) async {
    String name = "from files";
    if (controller.text.trim().isNotEmpty) {
      name = controller.text;
    }
    if (!isRename) {
      await SharedPrefs().saveNames(name);
    } else {
      await SharedPrefs().renameImage(name, placeInList);
    }
    Navigator.of(context).pop();
    Provider.of<StudyTimer>(
      listen: false,
      navigatorKey.currentContext!,
    ).notify();
    controller.clear();
    ImageDialog.show();
  }
}
