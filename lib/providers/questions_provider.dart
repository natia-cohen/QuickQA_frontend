import 'package:flutter/material.dart';
import '../services/api_service.dart';

class QuestionsProvider with ChangeNotifier {
  List<dynamic> _questions = [];
  bool _isLoading = false;

  List<dynamic> get questions => _questions;
  bool get isLoading => _isLoading;

  
  Future<void> loadQuestions() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<dynamic>? fetchedQuestions = await ApiService.fetchQuestions();
      print("Fetched questions: $fetchedQuestions"); 

      _questions = fetchedQuestions ?? []; 
    } catch (e) {
      print("Error fetching questions: $e");
      _questions = []; 
    }

    _isLoading = false;
    notifyListeners(); 
  }


  Future<void> addQuestion(String title, String content) async {
    try {
      await ApiService.addQuestion(title, content);
      await loadQuestions(); 
    } catch (e) {
      print("Error adding question: $e");
    }
  }

  Future<void> addAnswer(String questionId, String answerText) async {
    try {
      await ApiService.addAnswer(questionId, answerText);
      await loadQuestions(); 
    } catch (e) {
      print("Error adding answer: $e");
    }
  }
}
