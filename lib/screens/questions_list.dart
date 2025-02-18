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
      appBar: AppBar(
        title: Center(child: Text("Questions", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        elevation: 0, 
        backgroundColor: Colors.deepPurple, 
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10), 
        child: Consumer<QuestionsProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) return Center(child: CircularProgressIndicator());
            if (provider.questions.isEmpty) return Center(child: Text("No questions found.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)));

            return ListView.separated(
              itemCount: provider.questions.length,
              separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300, thickness: 1), // מפריד בין שאלות
              itemBuilder: (context, index) {
                var question = provider.questions[index];

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16), 
                    title: Text(question["title"] ?? "No title",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                    subtitle: Text(question["content"] ?? "No content available",
                        style: TextStyle(fontSize: 14, color: Colors.black87)),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.deepPurple), 
                    onTap: () {
                      context.go('/question/${question["_id"]}'); 
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddQuestionScreen()),
          );
        },
        backgroundColor: Colors.deepPurple, 
        child: Icon(Icons.add, size: 30, color: Colors.white), 
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:go_router/go_router.dart';
// import '../providers/questions_provider.dart';
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
//           if (provider.isLoading) return Center(child: CircularProgressIndicator());
//           if (provider.questions.isEmpty) return Center(child: Text("No questions found."));

//           return ListView.builder(
//             itemCount: provider.questions.length,
//             itemBuilder: (context, index) {
//               var question = provider.questions[index];

//               return ListTile(
//                 title: Text(question["title"] ?? "No title"),
//                 subtitle: Text(question["content"] ?? "No content available"),
//                 onTap: () {
//                   context.go('/question/${question["_id"]}'); // נווט עם ה-ID בנתיב
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


