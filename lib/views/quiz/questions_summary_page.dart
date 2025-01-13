import 'package:flutter/material.dart';
import 'package:turbbbites_flutter_app/views/quiz/questions.dart';
import 'package:turbbbites_flutter_app/views/quiz/questions_summary_list.dart';

class QuestionsSummaryPage extends StatelessWidget {
  const QuestionsSummaryPage(
      {super.key, required this.answers, required this.onRestart});

  final void Function() onRestart;
  final List<String> answers;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];
    for (int i = 0; i < answers.length; i++) {
      summary.add({
        'id': i,
        'question': questions[i].text,
        'user_answer': answers[i],
        'correct_answer': questions[i].answers[0],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where(
          (data) => data['user_answer'] == data['correct_answer'],
        )
        .length;

    return Column(
      children: [
        Text(
            'You answered $numCorrectQuestions out of $numTotalQuestions questions'),
        QuestionsSummary(summaryData),
        TextButton(
            onPressed: onRestart,
            child: const Text(
              'Restart Quiz',
            ))
      ],
    );
  }
}
