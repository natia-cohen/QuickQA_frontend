import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/questions_provider.dart';

class AddQuestionScreen extends StatefulWidget {
  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _submitQuestion() {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      return;
    }

    Provider.of<QuestionsProvider>(context, listen: false)
        .addQuestion(_titleController.text, _contentController.text);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ask a Question")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: "Details"),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitQuestion,
              child: Text("Submit"),
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

// class AddQuestionScreen extends StatefulWidget {
//   @override
//   _AddQuestionScreenState createState() => _AddQuestionScreenState();
// }

// class _AddQuestionScreenState extends State<AddQuestionScreen> {
//   final _titleController = TextEditingController();
//   final _contentController = TextEditingController();

//   void _submitQuestion() {
//     if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
//       Provider.of<QuestionsProvider>(context, listen: false)
//           .addQuestion(_titleController.text, _contentController.text);
//       Navigator.pop(context); 
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Add a Question")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(labelText: "Question Title"),
//             ),
//             TextField(
//               controller: _contentController,
//               decoration: InputDecoration(labelText: "Question Content"),
//               maxLines: 4,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _submitQuestion,
//               child: Text("Submit"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
