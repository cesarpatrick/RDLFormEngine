// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

Question jsonFormFromJson(String str) => Question.fromJson(json.decode(str));

String jsonFormToJson(Question data) => json.encode(data.toJson());

class Question {
  Question({required this.field, this.departament, required this.name});

  Field field;
  String? departament;
  String name;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        name: json["name"],
        departament: json["departament"],
        field: json["field"].map((x) => Field.fromJson(x)),
      );

  Map<String, dynamic> toJson() => {
        "name": this.name,
        "departament": this.departament,
        "field": field.toJson(),
      };
}

class Field {
  Field({
    required this.key,
    required this.type,
    required this.label,
    this.placeholder,
    this.required,
    this.value,
    this.items,
  });

  String key;
  String type;
  String label;
  String? placeholder;
  bool? required;
  dynamic value;
  List<Item>? items;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        key: json["key"],
        type: json["type"],
        label: json["label"],
        // ignore: prefer_if_null_operators
        placeholder: json["placeholder"] == null ? null : json["placeholder"],
        required: json["required"] == null ? null : json["required"],
        value: json["value"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        "type": type,
        "label": label,
        "placeholder": placeholder == null ? "" : placeholder,
        "required": required == null ? false : required,
        "value": value,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    required this.label,
    required this.value,
  });

  String label;
  dynamic value;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}
