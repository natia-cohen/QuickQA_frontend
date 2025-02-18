import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:5000';

  // 🔹 שליפת שאלות
  static Future<List<dynamic>> fetchQuestions() async {
    final response = await http.get(Uri.parse('$baseUrl/questions'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load questions');
    }
  }

  // 🔹 הוספת שאלה חדשה
  static Future<void> addQuestion(String title, String content) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/questions'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"title": title, "content": content, "user_id": "user123"}),
      );

      if (response.statusCode != 201) {
        throw Exception("Failed to add question");
      }
    } catch (e) {
      print("Error adding question: $e");
      throw e;
    }
  }

  // 🔹 הוספת תשובה לשאלה
  static Future<void> addAnswer(String questionId, String answerText) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/answer'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question_id": questionId, "answer": answerText, "user_id": "user123"}),
      );

      if (response.statusCode != 201) {
        throw Exception("Failed to add answer");
      }
    } catch (e) {
      print("Error adding answer: $e");
      throw e;
    }
  }
}
