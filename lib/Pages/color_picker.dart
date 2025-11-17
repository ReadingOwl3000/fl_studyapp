import 'package:fl_studyapp/functions/dark_light_mode_changer.dart';
import 'package:fl_studyapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatelessWidget {
  const ColorPickerDialog(this.darkLightModeChanger, {super.key});
  static show(DarkLightModeChanger darkLightModeChanger) => {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (_) => ColorPickerDialog(darkLightModeChanger),
    ),
  };

  final DarkLightModeChanger darkLightModeChanger;
  void changeColor(Color color) {
    darkLightModeChanger.color = color;
    darkLightModeChanger.notify();
  }

  @override
  Widget build(BuildContext context) {
    Color currentColor = darkLightModeChanger.color;

    return SizedBox(
      height: 300,
      width: 200,
      child: SimpleDialog(
        title: const Text("Pick a color"),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: HueRingPicker(
              portraitOnly: true,
              pickerColor: currentColor,
              onColorChanged: changeColor,
              enableAlpha: false,
              displayThumbColor: true,
            ),
          ),
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
