import 'dart:convert';

Question jsonFormFromJson(String str) => Question.fromJson(json.decode(str));

String jsonFormToJson(Question data) => json.encode(data.toJson());

class Question {
  Question({id, required this.field, this.departament, required this.name});

  int? id;
  QuestionField? field;
  String? departament;
  String name;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        name: json["name"],
        departament: json["departament"],
        field: json["field"] == null
            ? null
            : QuestionField.fromJson(json["field"]),
      );

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "name": this.name,
        "departament": this.departament,
        "field": field!.toJson(),
      };
}

class QuestionField {
  QuestionField({
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
  List<QuestionFieldItem>? items;

  factory QuestionField.fromJson(Map<String, dynamic> json) => QuestionField(
        key: json["key"],
        type: json["type"],
        label: json["label"],
        placeholder: json["placeholder"] == null ? null : json["placeholder"],
        required: json["required"] == null ? null : json["required"],
        value: json["value"],
        items: json["items"] == null
            ? null
            : List<QuestionFieldItem>.from(
                json["items"].map((x) => QuestionFieldItem.fromJson(x))),
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

class QuestionFieldItem {
  QuestionFieldItem({
    required this.label,
    required this.value,
  });

  String label;
  dynamic value;

  factory QuestionFieldItem.fromJson(Map<String, dynamic> json) =>
      QuestionFieldItem(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}
