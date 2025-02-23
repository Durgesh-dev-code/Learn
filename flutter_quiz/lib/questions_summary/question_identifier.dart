import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier({super.key, required this.data});
  final Map<String, Object> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: data['user_answer'] == data['correct_answer']
              ? Colors.blue[100]
              : Colors.pink[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          ((data['question_index'] as int) + 1).toString(),
        ),
      ),
    );
  }
}
