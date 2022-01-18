import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/WebUser.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/auth/auth.dart';
import 'package:admin/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main/components/side_menu.dart';

class MainScreen extends StatelessWidget {
  final Widget widget;

  const MainScreen({required this.widget}) : super();

  @override
  Widget build(BuildContext context) {
    final UserService userService = UserService();
    userService.checkUserLoggedIn(context);

    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: widget,
            ),
          ],
        ),
      ),
    );
  }
}
