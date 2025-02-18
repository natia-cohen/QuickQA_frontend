import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/questions_provider.dart';
import 'screens/questions_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuestionsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: QuestionsListScreen(),
      ),
    );
  }
}



