import 'dart:async';
import 'dart:convert';
import 'package:admin/models/Template.dart';
import 'package:admin/models/Variables.dart';
import 'package:admin/service/auth_key_service.dart';
import 'package:http/http.dart' as http;

class TemplateService {
  final AuthKeyService authKeyService = AuthKeyService();

  Future<List<Template>> getTemplates() async {
    final response = await http.post(Uri.parse(
        Variables.getTemplateListUrl() + authKeyService.getAuthKey()));

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

  Future<List<Template>> getTemplatesFilter(Template template) async {
    final response = await http.post(
        Uri.parse(
            Variables.getTemplateListFilterUrl() + authKeyService.getAuthKey()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(template));

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

  Future<Template> save(Template template) async {
    final response = await http.post(
        Uri.parse(Variables.getTemplateSaveUrl() + authKeyService.getAuthKey()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(template));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return Template.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load the template');
    }
  }
}
