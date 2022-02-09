import 'dart:async';
import 'dart:convert';
import 'package:admin/models/Question.dart';
import 'package:admin/models/Variables.dart';
import 'package:admin/service/auth_key_service.dart';
import 'package:http/http.dart' as http;

class QuestionService {
  final AuthKeyService authKeyService = AuthKeyService();

  Future<List<Question>> getQuestions() async {
    final response = await http.post(Uri.parse(
        Variables.getQuestionListUrl() + authKeyService.getAuthKey()));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Question>((json) => Question.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load the questions');
    }
  }

  Future<List<Question>> getQuestionsFilter(Question question) async {
    final response = await http.post(
        Uri.parse(
            Variables.getQuestionListFilterUrl() + authKeyService.getAuthKey()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(question));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Question>((json) => Question.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load the questions');
    }
  }

  void save(Question question) async {
    final response = await http.post(
        Uri.parse(Variables.getQuestionSaveUrl() + authKeyService.getAuthKey()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(question));

    print(jsonEncode(question));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load the template');
    }
  }
}
