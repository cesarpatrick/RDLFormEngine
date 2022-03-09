import 'dart:convert';

import 'package:admin/constants.dart';
import 'package:admin/models/Question.dart';
import 'package:admin/models/Template.dart';
import 'package:admin/models/json_to_form/JsonToForm.dart';
import 'package:admin/service/question_service.dart';
import 'package:admin/service/template_service.dart';
import 'package:admin/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TemplateFormBuilder extends StatefulWidget {
  final String? name;
  final String? departament;
  final List<Question>? questions;
  final int? templateId;
  const TemplateFormBuilder(
      {Key? key, this.name, this.departament, this.questions, this.templateId})
      : super(key: key);

  @override
  _TemplateFormBuilderState createState() => _TemplateFormBuilderState();
}

class _TemplateFormBuilderState extends State<TemplateFormBuilder> {
  ScrollController scrollController = ScrollController();

  TextEditingController searchValueController = TextEditingController();

  List<DropdownMenuItem<String>> inputTypeDropDownItemList =
      Util.getInputDropdownMenu();

  List<DropdownMenuItem<String>> departamentTypeDropDownItemList =
      Util.getDepartamentsDropdownMenu();

  late List<Question> questions = [];

  Template form = Template(name: "Template Name", questions: []);

  dynamic response;

  String _departamentDropdownValue = "";

  QuestionService questionApi = new QuestionService();
  TemplateService templateApi = TemplateService();

  late Future<List<Question>> questionList = questionApi.getQuestions();

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
    super.initState();
    form.name = widget.name!;
    form.departament = widget.departament!;
    form.id = widget.templateId;

    if (widget.questions != null && widget.questions!.length > 0) {
      questions = widget.questions!;
    }

    form.questions = questions;
  }

  void _undo() {
    questions.removeLast();
    form.questions = questions;
  }

  void addQuestion(Question question) {
    form.name = widget.name!;
    form.departament = widget.departament!;
    questions.add(question);
    form.questions = questions;
  }

  void save() {
    form.name = widget.name!;
    form.departament = widget.departament!;
    templateApi.save(form);
  }

  void filter() {
    Question question = Question(
        name: searchValueController.text,
        departament: _departamentDropdownValue,
        field: QuestionField(key: "", type: "", label: ""));

    questionList = questionApi.getQuestionsFilter(question);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context).size;

    return FutureBuilder<List<Question>>(
        future: questionList,
        builder: (context, snapshot) {
          List<Question> list = List<Question>.empty();

          if (snapshot.hasData) {
            list = snapshot.data!;

            List<Widget> options = [];
            for (Question question in list) {
              options.add(Container(
                  width: _screen.width,
                  child: Padding(
                      padding: EdgeInsets.all(1.5),
                      child: ElevatedButton(
                        onPressed: () => {
                          setState(() {
                            addQuestion(question);
                            _setScrollToEnd();
                          })
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: question.name,
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ))));
            }

            return Column(
              children: [
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
                                    onChanged: (value) {
                                      filter();
                                    },
                                    controller: searchValueController,
                                    decoration: InputDecoration(
                                      hintText: "Search",
                                      fillColor: primaryColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          filter();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              defaultPadding * 0.75),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: defaultPadding / 2),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          child: SvgPicture.asset(
                                              "assets/icons/Search.svg",
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
                                      filter();
                                    });
                                  },
                                  items: departamentTypeDropDownItemList,
                                )))
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
                          child: ListView(
                              padding: const EdgeInsets.all(8),
                              children: options)),
                      VerticalDivider(width: 5.0),
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
                                      questions =
                                          Template.fromJson(this.response)
                                              .questions;
                                      form = Template(
                                          id: widget.templateId,
                                          name: widget.name!,
                                          questions: questions);
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
                          onPressed: () => {
                            setState(() {
                              save();
                              Navigator.of(context).pop();
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
              ],
            );
          } else {
            return Text("No Questions");
          }
        });
  }
}
