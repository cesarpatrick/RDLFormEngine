import 'dart:convert';

import 'package:admin/models/Question.dart';
import 'package:admin/screens/form/components/form_builder/checkbox_input_form.dart';
import 'package:admin/screens/form/components/form_builder/input_form.dart';
import 'package:admin/screens/form/components/form_builder/radio_button_form.dart';
import 'package:admin/screens/form/components/form_builder/select_input_form.dart';
import 'package:admin/screens/form/components/form_builder/switch_input_form.dart';
import 'package:admin/screens/form/components/form_builder/text_area_input_form.dart';
import 'package:flutter/cupertino.dart';

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

  String convertQuestionToJson(Question question) {
    String json = jsonEncode(question);
    print(json);
    return json;
  }
}
