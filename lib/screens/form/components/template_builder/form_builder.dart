import 'package:admin/constants.dart';
import 'package:admin/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TemplateFormBuilder extends StatefulWidget {
  const TemplateFormBuilder({Key? key}) : super(key: key);

  @override
  _TemplateFormBuilderState createState() => _TemplateFormBuilderState();
}

class _TemplateFormBuilderState extends State<TemplateFormBuilder> {
  List<DropdownMenuItem<String>> inputTypeDropDownItemList =
      Util.getInputDropdownMenu();

  List<DropdownMenuItem<String>> departamentTypeDropDownItemList =
      Util.getDepartamentsDropdownMenu();

  String _departamentDropdownValue = "";
  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: _screen.width / 6,
                    child: Flexible(
                        child: TextField(
                            decoration: InputDecoration(
                      hintText: "Search",
                      fillColor: primaryColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(defaultPadding * 0.75),
                          margin: EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: SvgPicture.asset("assets/icons/Search.svg",
                              color: primaryColor),
                        ),
                      ),
                    )))),
                const SizedBox(
                  width: 20,
                ),
                Text("Departament", style: textStyle),
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
                  onChanged: (newValue) {
                    setState(() {
                      _departamentDropdownValue = newValue!;
                    });
                  },
                  items: departamentTypeDropDownItemList,
                )
              ]),
        ),
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: _screen.width / 3,
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 3),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Questions",
                    style: titleStyle2,
                  ),
                ),
                ListView(children: [
                  ElevatedButton(
                    onPressed: () => {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                    ),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text: "Test Question 1: How are You ?",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  ElevatedButton(
                    onPressed: () => {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                    ),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text: "Test Question 2: What's your name ?",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  ElevatedButton(
                    onPressed: () => {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                    ),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text: "Test Question 3: How old are you ?",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                ], shrinkWrap: true)
              ],
            ),
          ),
          VerticalDivider(width: 2.0),
          Container(
              width: _screen.width / 3,
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 3),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Preview",
                      style: titleStyle2,
                    ),
                  )
                ],
              )),
        ]),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => {setState(() {})},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryColor),
                  ),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: "Save", style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: "Cancel",
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
