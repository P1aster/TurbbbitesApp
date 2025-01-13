import 'package:flutter/material.dart';
import 'package:turbbbites_flutter_app/views/quiz/questions.dart';
import 'package:turbbbites_flutter_app/views/quiz/questions_page.dart';
import 'package:turbbbites_flutter_app/views/quiz/questions_start_page.dart';
import 'package:turbbbites_flutter_app/views/quiz/questions_summary_page.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  String activeScreen = 'start-screen';
  List<String> selectedAnswers = [];

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);


    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      activeScreen = 'start-screen';
      selectedAnswers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = QuestionsStartPage(onSwitchScreen: switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsPage(onSelectAnswer: chooseAnswer);
    }
    if (activeScreen == 'results-screen') {
      screenWidget = QuestionsSummaryPage(
          answers: selectedAnswers, onRestart: restartQuiz);
    }

    return Scaffold(
      body: screenWidget,
    );
  }
}
