import 'package:flutter/material.dart';
import 'package:untitled/quiz_controller.dart';
import 'package:untitled/screens/home.dart';
import 'package:flutter/services.dart';

late QuizController quizController;

void main() {
  runApp(const SouLouPanellinies());
}

class SouLouPanellinies extends StatefulWidget {
  const SouLouPanellinies({Key? key}) : super(key: key);

  @override
  State<SouLouPanellinies> createState() => _SouLouPanelliniesState();
}

class _SouLouPanelliniesState extends State<SouLouPanellinies> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return MaterialApp(
      title: 'Sou Lou Panellinies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        /*textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white, displayColor: Colors.black
        )*/
      ),
      home: const HomeScreen(),
    );
  }
}


