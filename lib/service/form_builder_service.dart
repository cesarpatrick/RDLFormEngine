import 'dart:convert';

import 'package:admin/models/Question.dart';
import 'package:admin/screens/form/components/form_builder/checkbox_input_form.dart';
import 'package:admin/screens/form/components/form_builder/input_form.dart';
import 'package:admin/screens/form/components/form_builder/radio_button_form.dart';
import 'package:admin/screens/form/components/form_builder/select_input_form.dart';
import 'package:admin/screens/form/components/form_builder/switch_input_form.dart';
import 'package:admin/screens/form/components/form_builder/text_area_input_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class FormBuilderService {
  Widget getFormByInputType(String name, String type, String departament) {
    switch (type) {
      case INPUT_TEXT:
        return InputForm(name: name, departament: departament);
      case TEXT_AREA_INPUT:
        return TextAreaInputForm(name: name, departament: departament);
      case SWITCH:
        return SwitchInputForm(name: name, departament: departament);
      case CHECKBOX_INPUT:
        return CheckboxInputForm(name: name, departament: departament);
      case RADIO_BUTTON_INPUT:
        return RadioButtonForm(name: name, departament: departament);
      case SELECT_INPUT:
        return SelectInputForm(name: name, departament: departament);
      default:
        return Container();
    }
  }

  Widget inputPreview(Question question) {
    TextEditingController labelController = TextEditingController();
    labelController.text = question.field.value;

    return Padding(
        padding: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(question.field.label,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
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

  String convertQuestionToJson(Question question) {
    String json = jsonEncode(question);
    print(json);
    return json;
  }
}
