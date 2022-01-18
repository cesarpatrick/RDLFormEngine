import 'package:admin/constants.dart';
import 'package:admin/models/Question.dart';
import 'package:flutter/material.dart';

class SelectInputForm extends StatefulWidget {
  final String name;
  final String? departament;
  const SelectInputForm({Key? key, required this.name, this.departament})
      : super(key: key);

  @override
  _SelectInputFormState createState() => _SelectInputFormState();
}

class _SelectInputFormState extends State<SelectInputForm> {
  bool initialValueRequiredSwitch = false;

  List<Item> items = [];

  TextEditingController labelController = TextEditingController();
  TextEditingController initialValueController = TextEditingController();

  TextEditingController labelItemController = TextEditingController();
  TextEditingController valueItemController = TextEditingController();

  bool _validateLabel = false;
  bool _validateItemLabel = false;
  bool _validateItemValue = false;

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

  Question _save(
      String label, String initialValue, bool required, List<Item> items) {
    Field field = Field(
        key: "key",
        type: "Select",
        label: label,
        value: initialValue,
        required: required,
        items: items);

    Question question = Question(
        field: field, name: widget.name, departament: widget.departament);

    print(question.toJson());
    return question;
  }

  void _undoField() {
    items.removeLast();
    setState(() {});
  }

  void _addOption(String label, dynamic value) {
    items.add(Item(label: label, value: value));
    labelItemController.text = "";
    valueItemController.text = "";
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
                    "Select Input Field",
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
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: labelController,
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
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
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
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: valueItemController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: primaryColor,
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      hintText: 'Enter the option value',
                      errorText: _validateItemValue
                          ? 'Option Value Can\'t Be Empty'
                          : null,
                    ),
                  ),
                ),
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

                            if (valueItemController.text.isEmpty) {
                              _validateItemValue = true;
                            } else {
                              _validateItemValue = false;
                            }

                            if (_validateItemLabel == false &&
                                _validateItemValue == false) {
                              _addOption(labelItemController.text,
                                  valueItemController.text);
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

                          if (_validateLabel == false) {
                            Navigator.of(context).pop(_save(
                                labelController.text,
                                initialValueController.text,
                                initialValueRequiredSwitch,
                                items));
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
            ))
      ],
    ));
  }
}
