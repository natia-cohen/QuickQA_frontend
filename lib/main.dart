import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'screens/questions_list.dart';
import 'screens/question_details.dart';
import 'providers/questions_provider.dart';

void main() {


  runApp(
    ChangeNotifierProvider(
      create: (context) => QuestionsProvider()..loadQuestions(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => QuestionsListScreen(),
      ),
      GoRoute(
        path: '/question/:id',
        builder: (context, state) {
          String questionId = state.pathParameters['id']!; // ✅ שינוי כאן
          return QuestionDetailsScreen(questionId: questionId);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'QA App',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'providers/questions_provider.dart';
// import 'screens/questions_list.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => QuestionsProvider()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: QuestionsListScreen(),
//       ),
//     );
//   }
// }



