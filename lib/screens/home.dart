import 'package:flutter/material.dart';
import 'package:untitled/components/screen.dart';

import '../main.dart';
import '../quiz_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _startQuiz() {
    quizController.init(context);
  }

  @override
  Widget build(BuildContext context) {
    quizController = QuizController();
    return Screen(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: _startQuiz, child: const Text("Έναρξη")),
          ],
        ),
      ),
    );
  }
}