import 'package:flutter/material.dart';

class QuestionsStartPage extends StatelessWidget {
  const QuestionsStartPage({required this.onSwitchScreen, super.key});

  final void Function() onSwitchScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome to the quiz!'),
          ElevatedButton(
            onPressed: onSwitchScreen,
            child: const Text('Start quiz'),
          ),
        ],
      ),
    );
  }
}
