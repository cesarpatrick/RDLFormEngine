import 'dart:convert';

import 'package:admin/constants.dart';
import 'package:admin/models/Question.dart';
import 'package:admin/models/Template.dart';
import 'package:admin/models/json_to_form/JsonToForm.dart';
import 'package:admin/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TemplateFormBuilder extends StatefulWidget {
  final String name;
  const TemplateFormBuilder({Key? key, required this.name}) : super(key: key);

  @override
  _TemplateFormBuilderState createState() => _TemplateFormBuilderState();
}

class _TemplateFormBuilderState extends State<TemplateFormBuilder> {
  ScrollController scrollController = ScrollController();

  List<DropdownMenuItem<String>> inputTypeDropDownItemList =
      Util.getInputDropdownMenu();

  List<DropdownMenuItem<String>> departamentTypeDropDownItemList =
      Util.getDepartamentsDropdownMenu();

  late List<Question> questions = [];

  QuestionField field = QuestionField(
      key: "keyInput",
      type: "Input",
      label: "Input Text Test",
      value: "",
      required: true);

  QuestionField field2 = QuestionField(
      key: "keyTextArea",
      type: "TextArea",
      label: "Text area test",
      value: "",
      required: true);

  QuestionField field3 = QuestionField(
      key: "key",
      type: "Switch",
      label: "Switch test",
      value: true,
      required: true);

  QuestionFieldItem item = QuestionFieldItem(label: "", value: "");
  QuestionFieldItem item2 = QuestionFieldItem(label: "Joana", value: "Joana");
  QuestionFieldItem item3 = QuestionFieldItem(label: "Maria", value: "Maria");
  QuestionFieldItem item4 = QuestionFieldItem(label: "Cesar", value: "Cesar");

  QuestionFieldItem item5 = QuestionFieldItem(label: "Honda", value: false);
  QuestionFieldItem item6 = QuestionFieldItem(label: "Fiat", value: false);
  QuestionFieldItem item7 = QuestionFieldItem(label: "Toyota", value: true);

  late List<QuestionFieldItem> items = [];
  late List<QuestionFieldItem> items2 = [];
  late List<QuestionFieldItem> items3 = [];

  QuestionField field4 = QuestionField(
      key: "key",
      type: "Select",
      label: "Select test",
      value: "",
      required: true,
      items: []);

  QuestionField field5 = QuestionField(
      key: "keyRadio",
      type: "RadioButton",
      label: "Radio Button test",
      value: "",
      required: true,
      items: []);

  QuestionField field6 = QuestionField(
      key: "keyRadio",
      type: "Checkbox",
      label: "Checkbox test",
      value: "",
      required: true,
      items: []);

  late Question question =
      Question(field: field, name: "Question Name", departament: "");

  late Question question2 =
      Question(field: field2, name: "Question Name", departament: "");

  late Question question3 =
      Question(field: field3, name: "Question Name", departament: "");

  late Question question4 =
      Question(field: field4, name: "Question Name", departament: "");

  late Question question5 =
      Question(field: field5, name: "Question Name", departament: "");

  late Question question6 =
      Question(field: field6, name: "Question Name", departament: "");

  Template form = Template(name: "Template Name", questions: []);

  dynamic response;

  void _setScrollToEnd() {
    var scrollPosition = scrollController.position;

    scrollController.animateTo(
      scrollPosition.maxScrollExtent + 150,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    form.name = widget.name;

    super.initState();
    //INput Text
    questions.add(question);
    //Text Area
    questions.add(question2);
    //Switch
    questions.add(question3);
    //Select
    items.add(item);
    items.add(item2);
    items.add(item3);
    items.add(item4);

    question4.field!.items = items;
    questions.add(question4);

    //Radio Button
    items2.add(item2);
    items2.add(item3);
    items2.add(item4);
    question5.field!.items = items2;
    questions.add(question5);

    //Checkbox Button
    items3.add(item5);
    items3.add(item6);
    items3.add(item7);
    question6.field!.items = items3;
    questions.add(question6);

    form.questions = questions;
    form.name = widget.name;
    print(jsonEncode(form));
  }

  void _addQuestion1() {
    question.field!.label = "Whats your name ?";
    questions.add(question);
    form.questions = questions;
  }

  void _addQuestion2() {
    question3.field!.label = "I agree with the terms and conditions";
    questions.add(question3);
    form.questions = questions;
  }

  void _addQuestion3() {
    question2.field!.label = "Job Description";
    questions.add(question2);
    form.questions = questions;
  }

  void _undo() {
    questions.removeLast();
    form.questions = questions;
  }

  String _departamentDropdownValue = "";
  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                    flex: 4,
                    child: Center(
                        child: TextField(
                            decoration: InputDecoration(
                      hintText: "Search",
                      fillColor: primaryColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(defaultPadding * 0.75),
                          margin: EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: SvgPicture.asset("assets/icons/Search.svg",
                              color: primaryColor),
                        ),
                      ),
                    )))),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Departament", style: textStyle)),
                Flexible(
                    flex: 2,
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          icon: Icon(
                            // Add this
                            Icons.arrow_drop_down, // Add this
                            color: primaryColor, // Add this
                          ),
                          value: _departamentDropdownValue,
                          style: const TextStyle(color: primaryColor),
                          dropdownColor: Colors.white,
                          underline: Container(
                            height: 2,
                            color: primaryColor,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              _departamentDropdownValue = newValue!;
                            });
                          },
                          items: departamentTypeDropDownItemList,
                        )))
              ]),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => {
                    setState(() {
                      _undo();
                    })
                  },
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
        ),
        SizedBox(height: 20),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: _screen.width / 4,
                height: _screen.height / 2,
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 3),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView(children: [
                      ElevatedButton(
                        onPressed: () => {
                          setState(() {
                            _addQuestion1();
                            _setScrollToEnd();
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
                                  text: "Test Question 1: What's your name ?",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 3),
                      ElevatedButton(
                        onPressed: () => {
                          setState(() {
                            _addQuestion2();
                            _setScrollToEnd();
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
                                  text:
                                      "Test Question 2: Terms and conditions ?",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 3),
                      ElevatedButton(
                        onPressed: () => {
                          setState(() {
                            _addQuestion3();
                            _setScrollToEnd();
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
                                  text: "Test Question 3: Job description ?",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ], shrinkWrap: true)
                  ],
                ),
              ),
              VerticalDivider(width: 2.0),
              Container(
                width: _screen.width / 2,
                height: _screen.height / 2,
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 3),
                    color: Colors.white),
                child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: JsonToForm(
                          form: jsonEncode(form),
                          onChanged: (dynamic response) {
                            setState(() {
                              this.response = response;
                              print(response);
                              questions =
                                  Template.fromJson(this.response).questions;
                              form = Template(
                                  name: widget.name, questions: questions);
                            });
                          },
                          actionSave: (data) {
                            print(data);
                          },
                          buttonSave: Container(
                            height: 40.0,
                            color: Colors.blueAccent,
                            child: const Center(
                              child: Text("Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ))
                      ],
                    )),
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
                  onPressed: () => {setState(() {})},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryColor),
                  ),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: "Save", style: TextStyle(color: Colors.white))
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
      ],
    );
  }
}
