import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      List<dynamic> fetchedQuestions = await ApiService.fetchQuestions();
      _questions = fetchedQuestions;
    } catch (e) {
      print("Error fetching questions: $e");
    }

    _isLoading = false;
    notifyListeners();
  }


  Future<void> addAnswer(String questionId, String answerText) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/answer'),
        body: jsonEncode({"question_id": questionId, "answer": answerText, "user_id": "user123"}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 201) {
        loadQuestions(); 
      } else {
        print("Failed to add answer");
      }
    } catch (e) {
      print("Error adding answer: $e");
    }
  }

  Future<void> addQuestion(String title, String content) async {
  try {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/questions'),
      body: jsonEncode({"title": title, "content": content, "user_id": "user123"}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 201) {
      loadQuestions(); // רענון השאלות אחרי הוספה
    } else {
      print("Failed to add question");
    }
  } catch (e) {
    print("Error adding question: $e");
  }
}

}
