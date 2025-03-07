import 'package:fl_studyapp/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Wigets/timer_widget.dart';

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
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<StudyTimer>(listen: false, context).timer?.cancel();
          Provider.of<StudyTimer>(listen: false, context).runTimer(context);
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
