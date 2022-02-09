import 'package:admin/constants.dart';
import 'package:admin/models/WebUser.dart';
import 'package:admin/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserService userService = UserService();

    return Drawer(
      backgroundColor: Colors.white70,
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[250],
              ),
              child: Column(children: [
                Image.asset("assets/images/logo.png", width: 110, height: 110),
                SizedBox(height: 5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.blue[900],
                        size: 15.0,
                      ),
                      SizedBox(width: 5),
                      Text(
                          userService.getUser().firstName! +
                              " " +
                              userService.getUser().lastName!,
                          style: TextStyle(color: Colors.blue[900]))
                    ])
              ])),
          DrawerListTile(
            title: "Forms",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              Navigator.pushNamed(context, HOME_ROUTE);
            },
          ),
          DrawerListTile(
            title: "Questions",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.pushNamed(context, QUESTIONS_ROUTE);
            },
          ),
          // DrawerListTile(
          //   title: "Task",
          //   svgSrc: "assets/icons/menu_task.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Documents",
          //   svgSrc: "assets/icons/menu_doc.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Store",
          //   svgSrc: "assets/icons/menu_store.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Notification",
          //   svgSrc: "assets/icons/menu_notification.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Profile",
          //   svgSrc: "assets/icons/menu_profile.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Settings",
          //   svgSrc: "assets/icons/menu_setting.svg",
          //   press: () {},
          // ),
          DrawerListTile(
            title: "Sign Out",
            svgSrc: "assets/icons/exit_icon.svg",
            press: () {
              userService.setUser(Webuser());
              userService.updatePrefs("", "");
              userService.checkUserLoggedIn(context);
            },
          )
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: Color(0xFFE8F5E9),
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Color(0xFF33691E),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Color(0xFF33691E)),
      ),
    );
  }
}
