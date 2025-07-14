import 'package:fl_studyapp/Pages/input_time_dialog.dart';
import 'package:fl_studyapp/functions/dark_light_mode_changer.dart';
import 'package:fl_studyapp/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Widgets/timer_widget.dart';
import 'package:fl_studyapp/shared_prefs.dart';
import 'Pages/image_dialog.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DarkLightModeChanger()..getModePrefs(),
      child: ChangeNotifierProvider(
        create: (_) => StudyTimer(),
        child: MyApp(),
      ),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkLightModeChanger>(
      builder:
          (context, darkLightModeChanger, _) => MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
              brightness: Brightness.dark,
            ),
            themeMode: darkLightModeChanger.mode,
            home: const MyHomePage(title: 'Pomodoro Timer App yay'),
            navigatorKey: navigatorKey,
          ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool _isLoading = true;
  static late List<String> imageList;
  static late List<String> nameOfImagesList;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await SharedPrefs().getPrefs();
    TimerWidget.buildTime(StudyTimer.focusDuration);
    imageList = await SharedPrefs().getImages();
    nameOfImagesList = await SharedPrefs().getNames();
    ImageDialog.currentImage = await SharedPrefs().getCurrentImage();
    setState(() {
      _isLoading = false; // initialization  complete
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Consumer<DarkLightModeChanger>(
      builder:
          (context, darkLightModeChanger, _) => Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
              actions: [
                IconButton(
                  onPressed: () {
                    InputTimeDialog.show(true);
                  },
                  icon: Icon(Icons.access_alarms_rounded),
                  tooltip: "focus timer settings",
                ),
                IconButton(
                  onPressed: () {
                    InputTimeDialog.show(false);
                  },
                  icon: Icon(Icons.snooze_rounded),
                  tooltip: "break timer settings",
                ),
                IconButton(
                  onPressed: () {
                    //print("image picker here");
                    ImageDialog.show();
                  },
                  icon: Icon(Icons.image),
                ),
                IconButton(
                  onPressed: () {
                    darkLightModeChanger.toggleModePrefs();
                  },
                  tooltip: "Toggle Dark/Light Mode",
                  icon: Icon(darkLightModeChanger.getCurrentIcon()),
                ),
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ImageDialog.currentImage,
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TimerWidget.buildTime(
                      Provider.of<StudyTimer>(
                        listen: true,
                        context,
                      ).durationNotifier.value,
                    ),
                  ],
                ),
              ),
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                var timer = Provider.of<StudyTimer>(listen: false, context);
                if (!timer.isPlaying) {
                  timer.runTimer();
                } else {
                  timer.pauseTimer();
                }
              },
              tooltip:
                  Provider.of<StudyTimer>(listen: true, context).isPlaying
                      ? "Pause player"
                      : "Start timer",
              child:
                  Provider.of<StudyTimer>(listen: true, context).isPlaying
                      ? Icon(Icons.pause_rounded)
                      : Icon(Icons.play_arrow_rounded),
              //const Icon(Icons.play_arrow_rounded),
            ),
          ),
    );
  }
}
