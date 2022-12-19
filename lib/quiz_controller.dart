import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/quiz.dart';
import 'package:untitled/screens/quiz.dart';
import 'package:untitled/screens/results.dart';

StreamController timeLeftStreamController = StreamController.broadcast();
Stream timeLeftStream = timeLeftStreamController.stream;
int maxSeconds = 30;

class QuizController {
  Quiz quiz = Quiz();
  late BuildContext context;
  QuizController();
  final stopwatch = Stopwatch();
  late Timer updateClock;

  late StreamSubscription quizStateStreamSubscription;

  void timeInit(BuildContext context) {
    stopwatch.start();
    updateClock = Timer.periodic(
        const Duration(milliseconds: 100),
            (timer) {
          timeLeftStreamController.add([maxSeconds-stopwatch.elapsed.inSeconds, ((maxSeconds*1000) - stopwatch.elapsed.inMilliseconds)/(maxSeconds*1000)]);
          if (stopwatch.elapsed.inSeconds >= maxSeconds) {
            submit(context, -1);
          }
        }
    );
  }

  void init(BuildContext context) {
    quizStateStreamSubscription = quizStateStream.listen((event) => {
      if (event == "not playing"){
        stopwatch..stop()..reset()
      },
      if (event == "new slide"){
        stopwatch..reset()..start()
      }
    }
    );
    quiz = Quiz();
    timeInit(context);
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const QuizScreen();
            }
        )
    );
  }

  void submit(BuildContext context, int answer) {
    stopwatch..stop()..reset();
    quiz.givenAnswers.add(answer);
    if (answer == quiz.slides[quiz.currIndex].correctAnswer) {
      quiz.totalScore++;
    }
    nextSlide(context);
  }
  void nextSlide(BuildContext context) {
    if (!isLastSlide()) {
      quiz.currIndex++;
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const QuizScreen();
              }
          )
      );
    }
    else {
      showResults(context);
    }
  }

  void showResults(BuildContext context) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const ResultsScreen();
            }
        )
    );
  }

  void end(BuildContext context) {
    Navigator.pop(context);
    quiz.clear();
  }

  bool isLastSlide() {
    return quiz.slides[quiz.currIndex] == quiz.slides.last;
  }

  Slide getSlide(int index) {
    return quiz.slides[index];
  }
}