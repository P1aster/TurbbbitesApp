import 'package:flutter/material.dart';

class QuestionsSummaryItem extends StatelessWidget {
  const QuestionsSummaryItem(this.data, {super.key});

  final Map<String, Object> data;

  @override
  Widget build(BuildContext context) {
    final isCorrect = data['user_answer'] == data['correct_answer'];
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          isCorrect ? Text("IS CORRECT") : Text("IS INCORRECT"),
          const SizedBox(
            height: 5,
          ),
          Text(data['user_answer'] as String),
          Text(data['correct_answer'] as String),
        ],
      ),
    );
  }
}
