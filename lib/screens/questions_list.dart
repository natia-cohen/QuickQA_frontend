import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/questions_provider.dart';
import 'add_question.dart';

class QuestionsListScreen extends StatefulWidget {
  @override
  _QuestionsListScreenState createState() => _QuestionsListScreenState();
}

class _QuestionsListScreenState extends State<QuestionsListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
        Provider.of<QuestionsProvider>(context, listen: false).loadQuestions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Questions")),
      body: Consumer<QuestionsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) return Center(child: CircularProgressIndicator());
          if (provider.questions.isEmpty) return Center(child: Text("No questions found."));

          return ListView.builder(
            itemCount: provider.questions.length,
            itemBuilder: (context, index) {
              var question = provider.questions[index];

              return ListTile(
                title: Text(question["title"] ?? "No title"),
                subtitle: Text(question["content"] ?? "No content available"),
                onTap: () {
                  context.go('/question/${question["_id"]}'); // נווט עם ה-ID בנתיב
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddQuestionScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/questions_provider.dart';
// import 'question_details.dart'; 
// import 'add_question.dart'; 

// class QuestionsListScreen extends StatefulWidget {
//   @override
//   _QuestionsListScreenState createState() => _QuestionsListScreenState();
// }

// class _QuestionsListScreenState extends State<QuestionsListScreen> {
//   @override
//   void initState() {
//     super.initState();
    
//     Future.microtask(() => 
//         Provider.of<QuestionsProvider>(context, listen: false).loadQuestions());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Questions")),
//       body: Consumer<QuestionsProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (provider.questions == null || provider.questions.isEmpty) {
//             return Center(child: Text("No questions found."));
//           }

//           return ListView.builder(
//             itemCount: provider.questions.length,
//             itemBuilder: (context, index) {
//               var question = provider.questions[index];

//               return ListTile(
//                 title: Text(question["title"] ?? "No title"), 
//                 subtitle: Text(question["content"] ?? "No content available"),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => QuestionDetailsScreen(question: question),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddQuestionScreen()),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
