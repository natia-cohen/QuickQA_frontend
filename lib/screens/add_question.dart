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
      appBar: AppBar(
        title: Center(child: Text("Ask a Question")),
        backgroundColor: Colors.blueAccent, 
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, 
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Ask a New Question",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: "Details",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200, 
                child: ElevatedButton(
                  onPressed: _submitQuestion,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[100], // רקע עדין לכל המסך
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
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _contentController = TextEditingController();

//   void _submitQuestion() {
//     if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
//       return;
//     }

//     Provider.of<QuestionsProvider>(context, listen: false)
//         .addQuestion(_titleController.text, _contentController.text);

//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Ask a Question")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(labelText: "Title"),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _contentController,
//               decoration: InputDecoration(labelText: "Details"),
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

