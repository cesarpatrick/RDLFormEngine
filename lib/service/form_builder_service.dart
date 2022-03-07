import 'dart:convert';

import 'package:admin/models/Question.dart';
import 'package:admin/screens/form/components/question_builder/checkbox_input_form.dart';
import 'package:admin/screens/form/components/question_builder/input_date_form.dart';
import 'package:admin/screens/form/components/question_builder/input_text_form.dart';
import 'package:admin/screens/form/components/question_builder/radio_button_form.dart';
import 'package:admin/screens/form/components/question_builder/select_input_form.dart';
import 'package:admin/screens/form/components/question_builder/switch_input_form.dart';
import 'package:admin/screens/form/components/question_builder/text_area_input_form.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class FormBuilderService {
  Widget getFormByInputType(
      String name, String type, String departament, Question? question) {
    if (question!.id != null && question.id != 0) {
      question.name = name;
      question.field!.type = type;
      question.departament = departament;
    }

    switch (type) {
      case INPUT_TEXT:
        return InputTextForm(
            name: name, departament: departament, question: question);
      case TEXT_AREA_INPUT:
        return TextAreaInputForm(
            name: name, departament: departament, question: question);
      case SWITCH:
        return SwitchInputForm(
            name: name, departament: departament, question: question);
      case CHECKBOX_INPUT:
        return CheckboxInputForm(
            name: name, departament: departament, question: question);
      case RADIO_BUTTON_INPUT:
        return RadioButtonForm(
            name: name, departament: departament, question: question);
      case SELECT_INPUT:
        return SelectInputForm(
            name: name, departament: departament, question: question);
      case INPUT_DATE:
        return InputDateForm(
            name: name, departament: departament, question: question);
      default:
        return Container();
    }
  }

  Widget getFormPreviewByInputType(Question question, String type) {
    switch (type) {
      case INPUT_TEXT:
        return inputTextPreview(question);
      case TEXT_AREA_INPUT:
        return inputTextAreaPreview(question);
      case SWITCH:
        return switchInputPreview(question);
      case CHECKBOX_INPUT:
        return checkBoxInputPreview(question);
      case RADIO_BUTTON_INPUT:
        return radioButtonInputPreview(question);
      case SELECT_INPUT:
        return inputSelectPreview(question);
      case INPUT_DATE:
        return inputDatePreview(question);
      default:
        return Container();
    }
  }

  Widget inputTextPreview(Question question) {
    TextEditingController labelController = TextEditingController();
    labelController.text = question.field!.value;

    return Padding(
        padding: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Expanded(
                  child: Text(question.field!.label,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold))),
              SizedBox(height: 10),
              TextField(
                  style: TextStyle(color: Colors.black),
                  controller: labelController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                      )))
            ]));
  }

  Widget inputSelectPreview(Question question) {
    String _departamentDropdownValue = "";

    List<DropdownMenuItem<String>> list = [];

    list.add(DropdownMenuItem<String>(value: "", child: Text("")));

    if (question.field!.value != null &&
        question.field!.value != "" &&
        question.field!.items != null &&
        question.field!.items!.length > 0) {
      _departamentDropdownValue = question.field!.value;
    }

    if (question.field!.items != null) {
      for (QuestionFieldItem item in question.field!.items!) {
        list.add(DropdownMenuItem<String>(
            value: item.value, child: Text(item.label)));
      }
    }

    if (list.isEmpty) {
      return Container();
    } else {
      return Padding(
          padding: EdgeInsets.all(15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Text(question.field!.label, style: textStyle)),
                      const SizedBox(
                        width: 20,
                      ),
                      DropdownButton<String>(
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
                        onChanged: (newValue) {},
                        items: list,
                      )
                    ])
              ]));
    }
  }

  Widget switchInputPreview(Question question) {
    bool switchValue = false;

    if (question.field!.value == "true") {
      switchValue = true;
    }

    return Padding(
        padding: EdgeInsets.all(15),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Expanded(
                  child: Text(question.field!.label,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold))),
              SizedBox(width: 10),
              Switch(
                activeColor: Colors.green,
                inactiveTrackColor: Colors.grey,
                value: switchValue,
                onChanged: (value) {},
              )
            ]));
  }

  Widget radioButtonInputPreview(Question question) {
    dynamic selectedValue = question.field!.value;

    List<Widget> listWidget = [];

    if (question.field!.items != null) {
      for (QuestionFieldItem item in question.field!.items!) {
        listWidget.add(new Row(
          children: <Widget>[
            new Radio<dynamic>(
                activeColor: Colors.black,
                value: item.value,
                groupValue: selectedValue,
                onChanged: (dynamic value) {}),
            Expanded(child: Text(item.label, style: blackTextStyleNoBold)),
          ],
        ));
      }

      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(question.field!.label, style: blackTextStyle),
            new Container(
              margin: new EdgeInsets.only(top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: listWidget,
              ),
            )
          ]);
    } else {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text(question.field!.label, style: blackTextStyle)]);
    }
  }

  Widget inputTextAreaPreview(Question question) {
    TextEditingController valueController = TextEditingController();
    valueController.text = question.field!.value;

    return Padding(
        padding: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(question.field!.label,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold))),
              SizedBox(height: 10),
              Column(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                              height: 130,
                              width: 200,
                              child: TextField(
                                controller: valueController,
                                style: textStyle,
                                decoration: new InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 0.5,
                                      ),
                                    ),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    )
                                    //fillColor: Colors.green
                                    ),
                                minLines:
                                    5, // any number you need (It works as the rows for the textarea)
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              )),
                        ],
                      )),
                ],
              )
            ]));
  }

  Widget checkBoxInputPreview(Question question) {
    List<Widget> listWidget = [];

    if (question.field!.items != null) {
      for (QuestionFieldItem item in question.field!.items!) {
        bool boolValue = false;

        if (item.value == "true") {
          boolValue = true;
        }

        listWidget.add(new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Checkbox(
                activeColor: Colors.black,
                value: boolValue,
                onChanged: (dynamic value) {}),
            Expanded(child: Text(item.label, style: blackTextStyleNoBold)),
          ],
        ));
      }

      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(question.field!.label, style: blackTextStyle),
            new Container(
              margin: new EdgeInsets.only(top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: listWidget,
              ),
            )
          ]);
    } else {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text(question.field!.label, style: blackTextStyle)]);
    }
  }

  Widget inputDatePreview(Question question) {
    TextEditingController labelController = TextEditingController();
    labelController.text = question.field!.value;

    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(question.field!.label, style: blackTextStyle),
              InkWell(
                  // onTap: () {
                  //   selectDate();
                  // },
                  child: new TextFormField(
                initialValue: "12-05-2022",
                style: TextStyle(color: Colors.black),
                readOnly: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  hintText: "DD-MM-YYYY",
                  iconColor: Colors.black,
                  //prefixIcon: Icon(Icons.date_range_rounded),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.calendar_today_rounded),
                    color: Colors.black,
                  ),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }

  String convertQuestionToJson(Question question) {
    String json = jsonEncode(question);
    print(json);
    return json;
  }
}
