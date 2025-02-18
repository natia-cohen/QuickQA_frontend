import 'package:flutter/material.dart';
import '../services/api_service.dart';

class QuestionsProvider extends ChangeNotifier {
  List<dynamic> _questions = [];

  List<dynamic> get questions => _questions;

  Future<void> loadQuestions() async {
    _questions = await ApiService.fetchQuestions();
    notifyListeners();  
  }
}
