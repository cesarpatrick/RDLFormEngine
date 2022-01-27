import 'dart:async';
import 'dart:convert';
import 'package:admin/constants.dart';
import 'package:admin/models/Question.dart';
import 'package:admin/models/Template.dart';
import 'package:admin/service/auth_key_service.dart';
import 'package:http/http.dart' as http;

class QuestionService {
  final AuthKeyService authKeyService = AuthKeyService();

  Future<List<Question>> getTemplates() async {
    final response = await http.post(
        Uri.parse(SERVER_URL + QUESTION_LIST + authKeyService.getAuthKey()));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Template>((json) => Template.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load the templates');
    }
  }

  Future<Question> getTemplatesById(String id) async {
    final response = await http.post(Uri.parse(
        SERVER_URL + QUESTION_URL + id + "/" + authKeyService.getAuthKey()));

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
