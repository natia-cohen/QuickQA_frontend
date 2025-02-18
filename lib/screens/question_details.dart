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
        appBar: AppBar(
          title: Center(child: Text("Question Not Found")),
        ),
        body: Center(child: Text("No question found with this ID.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(question["title"] ?? "No Title")),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question["content"] ?? "No content available",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Divider(),
            Text(
              "Answers:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: question["answers"] != null && question["answers"].isNotEmpty
                  ? ListView.separated(
                      itemCount: question["answers"].length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        var answer = question["answers"][index];
                        return ListTile(
                          title: Text(
                            answer["text"] ?? "No text",
                            style: TextStyle(fontSize: 16),
                          ),
                          subtitle: Text(
                            "By ${answer["user_id"] ?? "Anonymous"}",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No answers yet.",
                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                      ),
                    ),
            ),
            Divider(),
            SizedBox(height: 10),

           Center(
  child: Container(
    width: MediaQuery.of(context).size.width * 0.75, 
    child: TextField(
      controller: _answerController,
      decoration: InputDecoration(
        labelText: "Add an answer",
        border: OutlineInputBorder( 
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10), 
      ),
    ),
  ),
),


          

            Center(
             child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submitAnswer,
              style: ElevatedButton.styleFrom(
               padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), 
               textStyle: TextStyle(fontSize: 16),
               shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), 
               ),
              ),
              child: _isSubmitting
                  ? SizedBox(
                      width: 20, 
                      height: 20, 
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                   : Text("Submit"),
                  ),
           ),

          
          ],
        ),
      ),
    );
  }
}

