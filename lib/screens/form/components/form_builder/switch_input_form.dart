import 'package:admin/constants.dart';
import 'package:admin/models/Question.dart';
import 'package:flutter/material.dart';

class SwitchInputForm extends StatefulWidget {
  final String name;
  final String? departament;
  const SwitchInputForm({Key? key, required this.name, this.departament})
      : super(key: key);

  @override
  _SwitchInputFormState createState() => _SwitchInputFormState();
}

class _SwitchInputFormState extends State<SwitchInputForm> {
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

  Question _save(String label, String initialValue, bool required) {
    Field field = Field(
        key: "key",
        type: "Switch",
        label: label,
        value: initialValue,
        required: required);

    Question question = Question(
        field: field, name: widget.name, departament: widget.departament);

    print(question.toJson());
    return question;
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
                  inactiveTrackColor: Colors.redAccent,
                  onChanged: (value) {
                    setState(() {
                      initialValueRequiredSwitch = value;
                    });
                  },
                )
              ]),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
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
                  inactiveTrackColor: Colors.redAccent,
                  onChanged: (value) {
                    setState(() {
                      initialValueSelectedSwitch = value;
                    });
                  },
                )
              ]),
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
                              Navigator.of(context).pop(_save(
                                  labelController.text,
                                  initialValueController.text,
                                  initialValueRequiredSwitch));
                            }
                          })
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
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
