import 'package:flutter/material.dart';
import 'package:turbbbites_flutter_app/views/quiz/questions.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key, required this.onSelectAnswer});

  final void Function(String) onSelectAnswer;

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(currentQuestion.text),
          ...currentQuestion.shuffledAnswers.map((answer) {
            return OutlinedButton(
              onPressed: () {
                answerQuestion(answer);
              },
              child: Text(answer),
            );
          }),
        ],
      ),
    );
  }
}
