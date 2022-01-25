import 'package:admin/models/ListQuestions.dart';
import 'package:admin/screens/main/components/header.dart';
import 'package:admin/util.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class Questions extends StatefulWidget {
  const Questions({
    Key? key,
  }) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  List<DropdownMenuItem<String>> departamentTypeDropDownItemList =
      Util.getDepartamentsDropdownMenu();

  String _departamentDropdownValue = "";

  @override
  Widget build(BuildContext context) {
    Size _screen = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: <Widget>[
                  Container(
                      width: _screen.width / 6,
                      child: Center(
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
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, NEW_QUESTION_FORM);
                  },
                  icon: Icon(Icons.add),
                  label: Text("New"),
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding /
                            (Responsive.isMobile(context) ? 2 : 1),
                      ),
                      backgroundColor: primaryColor),
                )
              ]),
          SizedBox(
            height: 20,
          ),
          Text(
            "Questions",
            style: TextStyle(
                fontSize: 20, color: primaryColor, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.green),
              child: DataTable2(
                columnSpacing: defaultPadding,
                minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text(
                      "Name",
                      style: textStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text("Date", style: textStyle),
                  ),
                  DataColumn(
                    label: Text("Departament", style: textStyle),
                  ),
                ],
                rows: List.generate(
                  demoRecentFiles.length,
                  (index) => templatesDataRow(demoRecentFiles[index]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

DataRow templatesDataRow(ListQuestions templateInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              templateInfo.icon!,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(templateInfo.title!, style: textStyle),
            ),
          ],
        ),
      ),
      DataCell(Text(templateInfo.date!, style: textStyle)),
      DataCell(Text(templateInfo.size!, style: textStyle)),
    ],
  );
}
