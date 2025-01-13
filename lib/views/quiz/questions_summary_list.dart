import 'package:flutter/material.dart';
import 'package:turbbbites_flutter_app/views/quiz/questions_summary_item.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: summaryData.map((data) {
        return QuestionsSummaryItem(data);
      }).toList(),
    );
  }
}
