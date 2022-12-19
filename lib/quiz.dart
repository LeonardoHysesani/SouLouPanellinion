import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:untitled/dummy_slides.dart';

class Slide {
  final String question;
  final List<String> answerTexts;
  final int correctAnswer;

  Slide(this.question, this.answerTexts, this.correctAnswer);

}

class Quiz {
  late List<Slide> slides = _getSlides();
  int currIndex = 0;
  int totalScore = 0;
  List<int> givenAnswers = [];

  Quiz();

  void clear() {
    slides = [];
    currIndex = 0;
    totalScore = 0;
    givenAnswers = [];
  }
}

List<Slide> _getSlides() {
  List<Slide> slides = [];
  List<int> used = [];
  for (int i = 0; i < 10; i++) {
    int temp;
    do {
      temp = Random().nextInt(dummySlides.length - 1);
    } while (used.contains(temp));
    used.add(temp);
    slides.add(dummySlides[used[i]]);
    if (kDebugMode) {
      print(dummySlides[used[i]].question);
    }
  }
  return slides;
}