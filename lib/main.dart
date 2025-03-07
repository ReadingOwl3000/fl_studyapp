import 'package:fl_studyapp/timer.dart';
import 'package:flutter/material.dart';
//import 'dart:async';
import 'package:provider/provider.dart';
import 'Wigets/timer_widget.dart';

//import 'Pages/end_dialog.dart';
//import 'timer.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => StudyTimer(), child: MyApp()));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      navigatorKey: navigatorKey,
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
  // Timer? timer;
  // static Duration timerDuration = Duration(
  //   minutes: 1,
  // ); //change duration here! or possibly durationNotifier.value

  // final ValueNotifier<Duration> durationNotifier = ValueNotifier<Duration>(
  //   timerDuration,
  // );

  // void runTimer() {
  //   timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  //   buildTime(timerDuration);
  //   durationNotifier.value = timerDuration;
  // }

  // void addTime() {
  //   final seconds = durationNotifier.value.inSeconds - 1;
  //   if (seconds < 0) {
  //     timer?.cancel();
  //     EndDialog.showEndMessage(context);
  //   } else {
  //     durationNotifier.value = Duration(seconds: seconds);
  //     set();
  //   }
  // }

  void set() {
    setState(() {});
  }

  //var timerClass = Provider.of<StudyTimer>(listen: false, context)
  // Widget buildTime(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final hours = twoDigits(duration.inHours);
  //   final minutes = twoDigits(duration.inMinutes.remainder(60));
  //   final seconds = twoDigits(duration.inSeconds.remainder(60));
  //   double scale = 4;
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text(hours, textScaler: TextScaler.linear(scale)),
  //       Text(":", textScaler: TextScaler.linear(scale)),
  //       Text(minutes, textScaler: TextScaler.linear(scale)),
  //       Text(":", textScaler: TextScaler.linear(scale)),
  //       Text(seconds, textScaler: TextScaler.linear(scale)),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TimerWidget().buildTime(
                Provider.of<StudyTimer>(
                  listen: true,
                  context,
                ).durationNotifier.value,
              ),

              // TimerWidget.buildTime(timerClass.durationNotifier.value),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<StudyTimer>(listen: false, context).timer?.cancel();
          Provider.of<StudyTimer>(listen: false, context).runTimer(context);

          // buildTime(timerDuration);
          // durationNotifier.value = timerDuration;
        },
        tooltip: 'start timer',
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }

  @override
  void dispose() {
    Provider.of<StudyTimer>(listen: false, context).timer?.cancel();
    Provider.of<StudyTimer>(listen: false, context).durationNotifier.dispose();
    super.dispose();
  }
}

// for future reference https://medium.com/@dtejaswini.06/building-a-countdown-timer-in-flutter-with-animation-a-step-by-step-guide-9ffa91e3d26e
