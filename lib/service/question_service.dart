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

  // Future<Question> getQuestionById(String id) async {
  // final response = await http.post(Uri.parse(Variables.getTemplateListUrl()
  //     "/" +
  //     authKeyService.getAuthKey()));

  // if (response.statusCode == 200) {
  //   // If the server did return a 200 OK response,
  //   // then parse the JSON.

  //   return Question.fromJson(jsonDecode(response.body));
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   throw Exception('Failed to load the template');
  // }
  // }

  Future<Question> save(Question question) async {
    print(jsonEncode(question));
    final response = await http.post(
        Uri.parse(Variables.getQuestionSaveUrl() + authKeyService.getAuthKey()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(question));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return Question.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load the template');
    }
  }
}
