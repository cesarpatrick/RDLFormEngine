import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/auth/auth.dart';
import 'package:admin/screens/form/components/form_builder/new_question_form.dart';
import 'package:admin/screens/form/main_screen.dart';
import 'package:admin/service/auth_key_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/form/components/questions.dart';
import 'screens/form/components/template_builder/new_template_form.dart';
import 'screens/form/components/templates.dart';
import 'screens/main/page_not_found_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final AuthKeyService keyService = AuthKeyService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Form Engine',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        initialRoute: LOGIN_ROUTE,
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (BuildContext context) =>
                Scaffold(body: Center(child: const NotFoundPage())),
          );
        },
        routes: {
          // When navigating to the "/" route, build the Login widget.
          LOGIN_ROUTE: (context) => Auth(
                title: "Form Engine",
              ),
          // When navigating to the "/dashboard" route, build the Dashboard widget.
          HOME_ROUTE: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) => MenuController(),
                    ),
                  ],
                  child: Container(
                    child: MainScreen(widget: Templates()),
                  )),
          QUESTIONS_ROUTE: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) => MenuController(),
                    ),
                  ],
                  child: Container(
                    child: MainScreen(widget: Questions()),
                  )),
          NEW_QUESTION_FORM: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) => MenuController(),
                    ),
                  ],
                  child: Container(
                    child: MainScreen(widget: NewQuestionForm()),
                  )),
          NEW_TEMPLATE_FORM: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) => MenuController(),
                    ),
                  ],
                  child: Container(
                    child: MainScreen(widget: NewTemplateForm()),
                  ))
        });
  }
}
