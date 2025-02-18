import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/questions_provider.dart';
import 'screens/questions_list.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuestionsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QA Forum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuestionsListScreen(),
    );
  }
}
