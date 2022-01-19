import 'package:admin/constants.dart';
import 'package:admin/models/Question.dart';
import 'package:flutter/material.dart';

import 'preview_form.dart';

class CheckboxInputForm extends StatefulWidget {
  final String name;
  final String? departament;
  const CheckboxInputForm({Key? key, required this.name, this.departament})
      : super(key: key);

  @override
  _CheckboxInputFormState createState() => _CheckboxInputFormState();
}

class _CheckboxInputFormState extends State<CheckboxInputForm> {
  Question question = Question(
      field: Field(
        key: "",
        label: "",
        type: "Checkbox",
        value: "",
      ),
      name: "");

  bool initialValueRequiredSwitch = false;
  bool initialValueOptionSwitch = false;

  List<Item> items = [];

  TextEditingController labelController = TextEditingController();
  TextEditingController initialValueController = TextEditingController();

  TextEditingController labelItemController = TextEditingController();

  bool _validateLabel = false;
  bool _validateItemLabel = false;

  dynamic response;

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
    Field field = Field(
        key: "key",
        type: "Checkbox",
        label: labelController.text,
        value: initialValueController.text,
        required: initialValueRequiredSwitch,
        items: items);

    Question question = Question(
        field: field, name: widget.name, departament: widget.departament);

    print(question.toJson());

    this.question = question;

    setState(() {});
  }

  void _undoField() {
    items.removeLast();
    setState(() {
      _updateQuestion();
    });
  }

  void _addOption(String label, dynamic value) {
    items.add(Item(label: label, value: value));
    labelItemController.text = "";
    _updateQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Checkbox Input Field",
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
                      });
                    },
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: labelController,
                    onChanged: (value) {
                      _updateQuestion();
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: primaryColor,
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      hintText: 'Enter the label',
                      errorText:
                          _validateLabel ? 'Label Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Options", style: titleStyle),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: labelItemController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: primaryColor,
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      hintText: 'Enter the option label',
                      errorText: _validateItemLabel
                          ? 'Option Label Can\'t Be Empty'
                          : null,
                    ),
                  ),
                ),
                Row(children: <Widget>[
                  const SizedBox(
                    width: 20,
                  ),
                  const Text('Selected', style: textStyle),
                  Switch(
                    activeColor: Colors.green,
                    value: initialValueOptionSwitch,
                    inactiveTrackColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        initialValueOptionSwitch = value;
                      });
                    },
                  ),
                ]),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => {
                          setState(() {
                            if (labelItemController.text.isEmpty) {
                              _validateItemLabel = true;
                            } else {
                              _validateItemLabel = false;
                            }

                            if (_validateItemLabel == false) {
                              _addOption(labelItemController.text,
                                  initialValueOptionSwitch.toString());
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
                                  text: "Add Option",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => {_undoField()},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.undo_rounded, size: 15),
                              ),
                              TextSpan(
                                  text: " Undo",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      )
                    ]),
                const SizedBox(height: 20),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      DataTable(
                          border: TableBorder.all(color: Colors.green),
                          columns: const <DataColumn>[
                            DataColumn(label: Text("Option", style: textStyle)),
                            DataColumn(label: Text("Value", style: textStyle)),
                          ],
                          rows: items
                              .map(
                                (item) => DataRow(
                                  cells: [
                                    DataCell(
                                        Text(item.label, style: textStyle)),
                                    DataCell(Text(item.value, style: textStyle))
                                  ],
                                ),
                              )
                              .toList())
                    ]),
                const SizedBox(height: 50),
                horizontalDivider,
                PreviewForm(question: this.question, inputType: CHECKBOX_INPUT),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => {
                        setState(() {
                          labelController.text.isEmpty
                              ? _validateLabel = true
                              : _validateLabel = false;

                          if (_validateLabel == false) {}
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
            ))
      ],
    ));
  }
}
