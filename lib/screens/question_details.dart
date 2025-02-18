import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/questions_provider.dart';

class QuestionDetailsScreen extends StatefulWidget {
  final String questionId;

  QuestionDetailsScreen({required this.questionId});

  @override
  _QuestionDetailsScreenState createState() => _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  final TextEditingController _answerController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<QuestionsProvider>(context, listen: false).loadQuestions();
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _submitAnswer() async {
    if (_answerController.text.isEmpty) return;

    setState(() {
      _isSubmitting = true;
    });

    await Provider.of<QuestionsProvider>(context, listen: false)
        .addAnswer(widget.questionId, _answerController.text);

    setState(() {
      _isSubmitting = false;
      _answerController.clear();
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionDetailsScreen(questionId: widget.questionId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionsProvider>(context);
    final question = provider.questions.firstWhere(
      (q) => q["_id"] == widget.questionId,
      orElse: () => {},
    );

    if (question.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Question Not Found")),
        body: Center(child: Text("No question found with this ID.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(question["title"] ?? "No Title")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question["content"] ?? "No content available", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Answers:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Expanded(
              child: question["answers"] != null && question["answers"].isNotEmpty
                  ? ListView.builder(
                      itemCount: question["answers"].length,
                      itemBuilder: (context, index) {
                        var answer = question["answers"][index];
                        return ListTile(
                          title: Text(answer["text"] ?? "No text"),
                          subtitle: Text("By ${answer["user_id"] ?? "Anonymous"}"),
                        );
                      },
                    )
                  : Text("No answers yet.", style: TextStyle(fontStyle: FontStyle.italic)),
            ),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(labelText: "Add an answer"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submitAnswer,
              child: _isSubmitting
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/questions_provider.dart';

// class QuestionDetailsScreen extends StatefulWidget {
//   final Map<String, dynamic> question;

//   QuestionDetailsScreen({required this.question});

//   @override
//   _QuestionDetailsScreenState createState() => _QuestionDetailsScreenState();
// }

// class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
//   final TextEditingController _answerController = TextEditingController();
//   bool _isSubmitting = false;

//   void _submitAnswer() async {
//     if (_answerController.text.isEmpty) return;

//     setState(() {
//       _isSubmitting = true;
//     });

//     await Provider.of<QuestionsProvider>(context, listen: false)
//         .addAnswer(widget.question["_id"], _answerController.text);

//     setState(() {
//       _isSubmitting = false;
//       _answerController.clear();
//     });
//   }

//   @override
//   void dispose() {
//     _answerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.question["title"])),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(widget.question["content"], style: TextStyle(fontSize: 18)),
//             SizedBox(height: 20),
//             Text("Answers:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             Expanded(
//               child: widget.question["answers"] != null && widget.question["answers"].isNotEmpty
//                   ? ListView.builder(
//                       itemCount: widget.question["answers"].length,
//                       itemBuilder: (context, index) {
//                         var answer = widget.question["answers"][index];
//                         return ListTile(
//                           title: Text(answer["text"]),
//                           subtitle: Text("By ${answer["user_id"]}"),
//                         );
//                       },
//                     )
//                   : Text("No answers yet.", style: TextStyle(fontStyle: FontStyle.italic)),
//             ),
//             TextField(
//               controller: _answerController,
//               decoration: InputDecoration(labelText: "Add an answer"),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _isSubmitting ? null : _submitAnswer,
//               child: _isSubmitting
//                   ? CircularProgressIndicator(color: Colors.white)
//                   : Text("Submit"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



