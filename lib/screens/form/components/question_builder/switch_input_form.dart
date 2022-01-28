import 'package:admin/constants.dart';
import 'package:admin/models/Question.dart';
import 'package:flutter/material.dart';

import 'question_preview_input.dart';

class SwitchInputForm extends StatefulWidget {
  final String name;
  final String? departament;
  const SwitchInputForm({Key? key, required this.name, this.departament})
      : super(key: key);

  @override
  _SwitchInputFormState createState() => _SwitchInputFormState();
}

class _SwitchInputFormState extends State<SwitchInputForm> {
  Question question = Question(
      field: QuestionField(
        key: "",
        label: "",
        type: "Switch",
        value: false,
      ),
      name: "");
  bool initialValueRequiredSwitch = false;
  bool initialValueSelectedSwitch = false;
  TextEditingController labelController = TextEditingController();
  TextEditingController initialValueController = TextEditingController();

  bool _validate = false;

  @override
  void initState() {
    super.initState();
    initialValueRequiredSwitch = false;
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
        type: "Switch",
        label: labelController.text,
        value: initialValueSelectedSwitch.toString(),
        required: initialValueRequiredSwitch);

    Question question = Question(
        field: field, name: widget.name, departament: widget.departament);

    print(question.toJson());

    this.question = question;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
        child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(0),
            child: Column(children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Switch Field",
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
                  value: initialValueRequiredSwitch,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      initialValueRequiredSwitch = value;
                      _updateQuestion();
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
              Row(children: <Widget>[
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Default State',
                  style: textStyle,
                ),
                Switch(
                  activeColor: Colors.green,
                  value: initialValueSelectedSwitch,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      initialValueSelectedSwitch = value;
                      _updateQuestion();
                    });
                  },
                )
              ]),
              horizontalDivider,
              QuestionPreviewInput(question: this.question, inputType: SWITCH),
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

                            if (_validate == false) {}
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
