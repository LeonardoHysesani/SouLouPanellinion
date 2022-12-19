import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/components/screen.dart';
import 'package:untitled/quiz_controller.dart';
import '../main.dart';

StreamController quizStateStreamController = StreamController.broadcast();
Stream quizStateStream = quizStateStreamController.stream;

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    quizStateStreamController.add("playing");
    quizStateStreamController.add("new slide");
    super.initState();
  }

  void quizExit() {
    Navigator.pop(context);
    quizStateStreamController.add("not playing");
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Screen(
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SafeArea(
                        minimum: const EdgeInsets.all(5),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              enableFeedback: true,
                              child: const Icon(
                                Icons.exit_to_app_rounded,
                                color: Colors.red,
                                size: 48,
                              ),
                              onTap: () => quizExit(),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const Info(),
                const QuestionCard(),
                for (int i = 0; i < quizController.quiz.slides[quizController.quiz.currIndex].answerTexts.length; i++)
                  AnswerButton(i: i, answer: quizController.quiz.slides[quizController.quiz.currIndex].answerTexts[i], shadowColor: i == 0 ? Colors.green : Colors.red,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> with SingleTickerProviderStateMixin {

  late StreamSubscription timeLeftStreamSubscription;

  double _progress = -1;
  int timeLeft = -1;

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    super.initState();
    timeLeftStreamSubscription = timeLeftStream.listen((event) {
      setState(
          () {
            timeLeft = event[0];
            _progress = event[1];
          }
      );
    });
  }

  @override
  void dispose() {
    timeLeftStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 50),
      child: Stack(
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Align(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Ιστορία"),
                    Text("Πρόταση " + (quizController.quiz.currIndex + 1).toString() + "/" + quizController.quiz.slides.length.toString()),
                    Text(_printDuration(Duration(seconds: timeLeft)))
                  ]
              ),
            ),
          ),
          Align(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(value: _progress, color: Color.lerp(Colors.green, Colors.red, 1-_progress),)
              )
          )
        ]
      ),
    );
  }
}


class QuestionCard extends StatefulWidget {
  const QuestionCard({Key? key}) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                //spreadRadius: 5,
                blurRadius: 0,
                offset: Offset(-10, -10)
            ),
          ]
      ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            minimum: const EdgeInsets.all(30),
            child: Center(
              child: Text(
                    quizController.quiz.slides[quizController.quiz.currIndex].question,
                    style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
            ),
          ),
        )
    );
  }
}


class AnswerButton extends StatefulWidget {
  const AnswerButton({Key? key, required this.i, required this.answer, required this.shadowColor}) : super(key: key);

  final int i;
  final String answer;
  final Color shadowColor;

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 50),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: widget.shadowColor,
                offset: const Offset(-5, -5)
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Material(
          color: Colors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: InkWell(
            enableFeedback: true,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            onTap: () => quizController.submit(context, widget.i),
            child: Align(
                alignment: Alignment.centerLeft,
                child: SafeArea(
                    minimum: const EdgeInsets.only(left: 20),
                    child: Text(widget.answer, style: const TextStyle(color: Colors.white, fontSize: 24), textAlign: TextAlign.left,)
                )
            ),
          ),
        ),
      ),
    );
  }
}

