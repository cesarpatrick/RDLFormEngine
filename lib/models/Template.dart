import 'dart:convert';

import 'package:admin/models/Question.dart';

Template jsonFormFromJson(String str) => Template.fromJson(json.decode(str));

String jsonFormToJson(Template data) => json.encode(data.toJson());

class Template {
  Template(
      {this.id, required this.name, required this.questions, this.departament});

  int? id;
  String name;
  List<Question> questions;
  String? departament;

  factory Template.fromJson(Map<String, dynamic> json) => Template(
        id: json["id"],
        name: json["name"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        departament: json["departament"],
      );

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "name": this.name,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "departament": this.departament
      };
}
