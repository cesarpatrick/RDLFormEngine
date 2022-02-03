import 'dart:io';
import 'package:admin/models/WebUser.dart';
import 'package:admin/models/Variables.dart';
import 'package:admin/screens/form/components/templates_screen.dart';
import 'package:admin/screens/form/main_screen.dart';
import 'package:admin/service/auth_key_service.dart';
import 'package:admin/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../responsive.dart';

class Auth extends StatefulWidget {
  final String? title;

  Auth({Key? key, this.title}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

_sharedPreferencesInit() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getString("username")!.isEmpty) {
    await prefs.setString('username', '');
    await prefs.setString('password', '');
  }
}

class _AuthState extends State<Auth> {
  final AuthKeyService service = AuthKeyService();
  final UserService userService = UserService();
  FocusNode passwordFocusNode = FocusNode();
  String? _username;
  String? _password;
  bool? _authorisingLogin;
  bool? _notAuthorised;
  bool? _notConnected;

  @override
  void initState() {
    super.initState();
    _authorisingLogin = false;
    _notAuthorised = false;
    _notConnected = false;
    _sharedPreferencesInit();
    checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title!)),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _authorisingLogin!
                  ? <Widget>[
                      CircularProgressIndicator(),
                    ]
                  : <Widget>[
                      Visibility(
                          visible: _notConnected!,
                          child: Text(
                            'Unable to connect to Server',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('images/logo.png'),
                      ),
                      Variables.baseUrl() == Variables.beta()
                          ? Text(
                              'BETA CONNECTION',
                              style: TextStyle(color: Colors.red),
                            )
                          : SizedBox.shrink(),
                      Container(
                        width: 500,
                        padding: EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 10.0),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: primaryColor,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            labelStyle: whiteTextStyle,
                            hintText: 'Username',
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _username = value;
                            });
                          },
                          textAlign: TextAlign.center,
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          onSubmitted: (newValue) {
                            FocusScope.of(context)
                                .requestFocus(passwordFocusNode);
                          },
                        ),
                      ),
                      Container(
                          width: 500,
                          padding: EdgeInsets.fromLTRB(70.0, 0, 70.0, 0.0),
                          child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: primaryColor,
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                labelStyle: whiteTextStyle,
                                hintText: 'Password'),
                            obscureText: true,
                            onChanged: (String value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            onSubmitted: (newValue) {
                              if (_username!.isNotEmpty &&
                                  newValue.isNotEmpty) {
                                setState(() {
                                  _password = newValue;
                                  _authorisingLogin = true;
                                });
                                userService.updatePrefs(_username!, _password!);
                                authUser(_username!, _password!, context);
                              }
                            },
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: defaultPadding * 1.5,
                              vertical: defaultPadding /
                                  (Responsive.isMobile(context) ? 2 : 1),
                            ),
                            backgroundColor: Colors.blue[900]),
                        onPressed: () {
                          if (_username!.isNotEmpty && _password!.isNotEmpty) {
                            setState(() {
                              _authorisingLogin = true;
                            });
                            userService.updatePrefs(_username!, _password!);
                            authUser(_username!, _password!, context);
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      _notAuthorised! && !_notConnected!
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.red,
                                child: Text(
                                  'Username or Password may be incorrect',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                          : Text('')
                    ],
            ),
          ),
        ),
      ),
    );
  }

  void checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String readName = '';
    String readPass = '';

    if (prefs.getString('username') != null &&
        prefs.getString('password') != null) {
      readName = prefs.getString('username').toString();
      readPass = prefs.getString('password').toString();
    }

    if (readName.isNotEmpty && readPass.isNotEmpty) {
      authUser(readName, readPass, context);
    }
  }

  void goToHome(String value) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainScreen(
              widget: TemplatesScreen(),
            )));
  }

  void authUser(String username, String password, BuildContext context) async {
    print('Authorising user');
    Webuser? authenticated;
    try {
      authenticated = await authenticate(username, password);
    } catch (e) {
      print('User unauthorised');
      if (e is SocketException) {
        setState(() {
          _notConnected = true;
        });
      }

      setState(() {
        _authorisingLogin = false;
        _notAuthorised = true;
      });
    }
    if (authenticated != null) {
      userService.setUser(authenticated);
      print('User authorised');
      service.setAuthkey(authenticated.key!);
      if (authenticated.key != null && authenticated.key!.isNotEmpty) {
        Navigator.pushNamed(context, '/home');
      }
    }
  }
}
