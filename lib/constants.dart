import 'package:flutter/material.dart';

const primaryColor = Color(0xFF33691E);
const secondaryColor = Colors.white;

const textGreenColor = Color(0xFF33691E);
const bgColor = Colors.white;

const titleStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: primaryColor);

const textStyle = TextStyle(color: textGreenColor, fontWeight: FontWeight.bold);
const whiteTextStyle =
    TextStyle(color: secondaryColor, fontWeight: FontWeight.bold);

const defaultPadding = 16.0;

//ROUTES
const String LOGIN_ROUTE = "/";
const String LOGOUT_ROUTE = "/logout";
const String HOME_ROUTE = "/home";
const String QUESTIONS_ROUTE = "/questions";
const String NEW_QUESTION_FORM = "/newQuestion";

//QUESTION TYPES
const String INPUT_TEXT = "INPUT TEXT";
const String SWITCH = "SWITCH";
const String CHECKBOX_INPUT = "CHECKBOX";
const String SELECT_INPUT = "SELECT INPUT";
const String TEXT_AREA_INPUT = "TEXT AREA";
const String RADIO_BUTTON_INPUT = "RADIO BUTTON";

//DEPARTAMENTS
const String IT = "INFORMATION TECHNOLOGY";
const String HR = "HUMAN RESOURCES";
const String WORKSHOP = "WORKSHOP";
const String OPERATIONS = "OPERATIONS";
