import 'package:admin/constants.dart';
import 'package:admin/models/Question.dart';
import 'package:admin/service/question_service.dart';
import 'package:flutter/material.dart';

import 'question_preview_input.dart';

class TextAreaInputForm extends StatefulWidget {
  final String name;
  final String? departament;
  final Question? question;
  const TextAreaInputForm(
      {Key? key, required this.name, this.departament, this.question})
      : super(key: key);

  @override
  _TextAreaInputFormState createState() => _TextAreaInputFormState();
}

class _TextAreaInputFormState extends State<TextAreaInputForm> {
  Question question = Question(
      field: QuestionField(
        key: "",
        label: "",
        type: "Input",
        value: "",
      ),
      name: "");

  bool initialValueSwitch = false;
  TextEditingController labelController = TextEditingController();
  TextEditingController initialValueController = TextEditingController();

  QuestionService questionService = QuestionService();

  bool _validate = false;

  @override
  void initState() {
    super.initState();
    initialValueSwitch = false;

    if (widget.question!.id != null && widget.question!.id != 0) {
      labelController.text = widget.question!.field!.label;
      initialValueController.text = widget.question!.field!.value;
      initialValueSwitch = widget.question!.field!.required!;
      question = widget.question!;
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    labelController.dispose();
    initialValueController.dispose();
    super.dispose();
  }

  void _updateQuestion() {
    QuestionField field = QuestionField(
        key: "key",
        type: "TextArea",
        label: labelController.text,
        value: initialValueController.text,
        required: initialValueSwitch);

    int? fieldId = widget.question!.field!.id;

    if (fieldId != null && fieldId != 0) {
      field.id = fieldId;
    }

    this.question.field = field;
    this.question.name = widget.name;
    this.question.departament = widget.departament;

    print(this.question.toJson());
  }

  void _save() {
    questionService.save(this.question);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(0),
            child: Column(children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Text Area Field",
                  style: titleStyle,
                ),
              ),
              Row(children: <Widget>[
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Required',
                  style: textStyle,
                ),
                Switch(
                  activeColor: Colors.green,
                  value: initialValueSwitch,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      initialValueSwitch = value;
                    });
                  },
                )
              ]),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _updateQuestion();
                    });
                  },
                  controller: labelController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: primaryColor,
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: 'Enter the label',
                    errorText: _validate ? 'Label Can\'t Be Empty' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: initialValueController,
                  onChanged: (value) {
                    setState(() {
                      _updateQuestion();
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: primaryColor,
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: 'Enter the initial value',
                  ),
                ),
              ),
              horizontalDivider,
              QuestionPreviewInput(
                  question: this.question, inputType: TEXT_AREA_INPUT),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => {
                          setState(() {
                            labelController.text.isEmpty
                                ? _validate = true
                                : _validate = false;

                            if (_validate == false) {
                              _save();
                              Navigator.of(context).pop(this.question);
                            }
                          })
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                        ),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "Save",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => {Navigator.of(context).pop()},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "Cancel",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ]))
      ],
    ));
  }
}
