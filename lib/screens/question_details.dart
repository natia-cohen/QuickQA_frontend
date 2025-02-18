import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/questions_provider.dart';

class QuestionDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> question;

  QuestionDetailsScreen({required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(question["title"])),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question["content"], style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Answers:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: question["answers"].length,
                itemBuilder: (context, index) {
                  var answer = question["answers"][index];
                  return ListTile(
                    title: Text(answer["text"]),
                    subtitle: Text("By ${answer["user_id"]}"),
                  );
                },
              ),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Add an answer"),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  Provider.of<QuestionsProvider>(context, listen: false)
                      .addAnswer(question["_id"], value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
