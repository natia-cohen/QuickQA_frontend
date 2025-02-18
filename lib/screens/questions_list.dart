import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/questions_provider.dart';

class QuestionsListScreen extends StatelessWidget {
  const QuestionsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questionsProvider = Provider.of<QuestionsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions List'),
      ),
      body: FutureBuilder(
        future: questionsProvider.loadQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (questionsProvider.questions.isEmpty) {
            return const Center(child: Text('No questions yet!'));
          }

          return ListView.builder(
            itemCount: questionsProvider.questions.length,
            itemBuilder: (context, index) {
              final question = questionsProvider.questions[index];
              return ListTile(
                title: Text(question['title']),
                subtitle: Text(question['content']),
                onTap: () {
                },
              );
            },
          );
        },
      ),
    );
  }
}
