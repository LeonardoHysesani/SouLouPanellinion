import 'package:flutter/material.dart';
import 'package:untitled/components/screen.dart';
import 'package:untitled/main.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<Icon> resultIcons = [];
  List<Color> resultColors = [];

  @override
  void initState() {
    setState(
        () {
          for (int i = 0; i < quizController.quiz.slides.length; i++) {
            if (quizController.quiz.givenAnswers[i] == -1) {
              resultColors.add(Colors.orange);
              resultIcons.add(Icon(Icons.timer, color: resultColors[i],));
            }
            else if (quizController.quiz.givenAnswers[i] == quizController.getSlide(i).correctAnswer) {
              resultColors.add(Colors.green);
              resultIcons.add(Icon(Icons.check, color: resultColors[i],));
            }
            else {
              resultColors.add(Colors.red);
              resultIcons.add(Icon(Icons.close, color: resultColors[i],));
            }
          }
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
                  //color: Colors.grey.withOpacity(0.5)
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    //border: Border.all(),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const Text("Αποτελέσματα"),
                      Text(quizController.quiz.totalScore.toString() + "/" + quizController.quiz.slides.length.toString()),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey.withOpacity(0.5),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        for (int i =0; i < quizController.quiz.slides.length; i++)
                          SafeArea(
                            minimum: const EdgeInsets.all(15),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: resultColors[i],
                                        //spreadRadius: 5,
                                        blurRadius: 0,
                                        offset: const Offset(-10, -10)
                                    ),
                                  ]
                              ),
                              child: SafeArea(
                                minimum: const EdgeInsets.all(15),
                                child: Row(
                                    children: [
                                      Flexible(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                    child: Text(
                                                      (i+1).toString() + ". " + quizController.getSlide(i).question,
                                                      textAlign: TextAlign.center,
                                                    )
                                                )
                                              ],
                                            ),
                                            SafeArea(
                                              minimum: const EdgeInsets.only(top: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: SafeArea(
                                                  minimum: const EdgeInsets.all(5),
                                                  child: Text("Λύση: " + quizController.getSlide(i).answerTexts[quizController.getSlide(i).correctAnswer]),
                                                ),
                                              ),
                                            ),
                                            SafeArea(
                                              minimum: const EdgeInsets.only(top: 10),
                                              child:  resultIcons[i]
                                            )
                                          ],
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                  ),
                  child: Material(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                    child: InkWell(
                      enableFeedback: true,
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      onTap: () => quizController.end(context),
                      child: const Center(
                          child: Text("Επιστροφή", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
