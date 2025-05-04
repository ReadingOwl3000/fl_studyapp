import 'package:fl_studyapp/main.dart';
import 'package:flutter/material.dart';

class ImageNameDialog extends StatelessWidget {
  const ImageNameDialog({super.key});
  static show() => showDialog(
    context: navigatorKey.currentContext!,
    builder: (_) => ImageNameDialog(),
  );
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
                      onSubmitted: (value) {},
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "image name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(onPressed: () {}, child: Text("Apply")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
