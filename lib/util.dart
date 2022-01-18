import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class Util {
  static List<DropdownMenuItem<String>> getInputDropdownMenu() {
    List<DropdownMenuItem<String>> list = [];

    list.add(DropdownMenuItem<String>(value: "", child: Text("")));
    list.add(
        DropdownMenuItem<String>(value: INPUT_TEXT, child: Text(INPUT_TEXT)));
    list.add(DropdownMenuItem<String>(value: SWITCH, child: Text(SWITCH)));
    list.add(DropdownMenuItem<String>(
        value: CHECKBOX_INPUT, child: Text(CHECKBOX_INPUT)));
    list.add(DropdownMenuItem<String>(
        value: SELECT_INPUT, child: Text(SELECT_INPUT)));
    list.add(DropdownMenuItem<String>(
        value: TEXT_AREA_INPUT, child: Text(TEXT_AREA_INPUT)));
    list.add(DropdownMenuItem<String>(
        value: RADIO_BUTTON_INPUT, child: Text(RADIO_BUTTON_INPUT)));

    return list;
  }

  static List<DropdownMenuItem<String>> getDepartamentsDropdownMenu() {
    List<DropdownMenuItem<String>> list = [];

    list.add(DropdownMenuItem<String>(value: "", child: Text("")));
    list.add(DropdownMenuItem<String>(value: IT, child: Text(IT)));
    list.add(DropdownMenuItem<String>(value: HR, child: Text(HR)));
    list.add(
        DropdownMenuItem<String>(value: OPERATIONS, child: Text(OPERATIONS)));
    list.add(DropdownMenuItem<String>(value: WORKSHOP, child: Text(WORKSHOP)));
    return list;
  }
}