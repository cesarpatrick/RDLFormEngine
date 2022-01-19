import 'package:admin/constants.dart';
import 'package:admin/models/Question.dart';
import 'package:admin/service/form_builder_service.dart';
import 'package:flutter/material.dart';

import 'preview_form.dart';

class InputForm extends StatefulWidget {
  final String name;
  final String? departament;
  const InputForm({Key? key, required this.name, this.departament})
      : super(key: key);

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  Question question = Question(
      field: Field(
        key: "",
        label: "",
        type: "Input",
        value: "",
      ),
      name: "");

  bool initialValueSwitch = false;
  TextEditingController labelController = TextEditingController();
  TextEditingController initialValueController = TextEditingController();

  FormBuilderService formBuilderService = FormBuilderService();

  bool _validate = false;

  @override
  void initState() {
    super.initState();
    initialValueSwitch = false;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    labelController.dispose();
    initialValueController.dispose();
    super.dispose();
  }

  void _updateQuestion() {
    Field field = Field(
        key: "key",
        type: "Input",
        label: labelController.text,
        value: initialValueController.text,
        required: initialValueSwitch);

    Question question = Question(
        field: field, name: widget.name, departament: widget.departament);

    print(question.toJson());

    this.question = question;
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
                  "Text Input Field",
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
                  inactiveTrackColor: Colors.redAccent,
                  onChanged: (value) {
                    setState(() {
                      initialValueSwitch = value;
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
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _updateQuestion();
                    });
                  },
                  controller: initialValueController,
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
              PreviewForm(question: this.question),
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
