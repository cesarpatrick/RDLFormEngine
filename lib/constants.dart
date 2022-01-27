import 'package:flutter/material.dart';

const primaryColor = Color(0xFF33691E);
const secondaryColor = Colors.white;

const textGreenColor = Color(0xFF33691E);
const bgColor = Colors.white;

const titleStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: primaryColor);

const titleStyle2 =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: primaryColor);

const textStyle = TextStyle(color: textGreenColor, fontWeight: FontWeight.bold);
const whiteTextStyle =
    TextStyle(color: secondaryColor, fontWeight: FontWeight.bold);
const blackTextStyle =
    TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);
const blackTextStyleNoBold = TextStyle(color: Colors.black, fontSize: 14);

const horizontalDivider = const Divider(
  thickness: 5, // thickness of the line
  indent: 20, // empty space to the leading edge of divider.
  endIndent: 20, // empty space to the trailing edge of the divider.
  color: primaryColor, // The color to use when painting the line.
  height: 20, // The divider's height extent.
);

const defaultPadding = 16.0;

//ROUTES
const String LOGIN_ROUTE = "/";
const String LOGOUT_ROUTE = "/logout";
const String HOME_ROUTE = "/home";
const String QUESTIONS_ROUTE = "/questions";
const String NEW_QUESTION_FORM = "/newQuestion";
const String NEW_TEMPLATE_FORM = "/newTemplate";

//QUESTION TYPES
const String INPUT_TEXT = "Input";
const String SWITCH = "Switch";
const String CHECKBOX_INPUT = "Checkbox";
const String SELECT_INPUT = "Select";
const String TEXT_AREA_INPUT = "TextArea";
const String RADIO_BUTTON_INPUT = "RadioButton";

//DEPARTAMENTS
const String IT = "INFORMATION TECHNOLOGY";
const String HR = "HUMAN RESOURCES";
const String WORKSHOP = "WORKSHOP";
const String OPERATIONS = "OPERATIONS";

//SERVER URL
const String SERVER_URL = "https://rdltr.com:8999/rdl-report-ws/ws/cache/";

//ENDPOINTS
const String TEMPLATE_LIST = "formTemplate/list/";
