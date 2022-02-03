import 'package:admin/models/Question.dart';
import 'package:admin/screens/main/components/header.dart';
import 'package:admin/screens/main/components/progress_bar.dart';
import 'package:admin/service/question_service.dart';
import 'package:admin/util.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  List<DropdownMenuItem<String>> departamentTypeDropDownItemList =
      Util.getDepartamentsDropdownMenu();

  String _departamentDropdownValue = "";

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size _screen = MediaQuery.of(context).size;
    QuestionService api = QuestionService();

    Future<List<Question>> questionList = api.getQuestions();

    return FutureBuilder<List<Question>>(
        future: questionList,
        builder: (context, snapshot) {
          List<Question> list = List<Question>.empty();

          if (snapshot.hasData) {
            list = snapshot.data!;
          } else {
            //todo: Break this down into a widget that way dont need to copy the code twice
            return Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Header(),
                      Header(),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            defaultPadding * 0.75),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: defaultPadding / 2),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: SvgPicture.asset(
                                            "assets/icons/Search.svg",
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
                            ])
                          ]),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Questions",
                        style: TextStyle(
                            fontSize: 20,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      ProgressBar()
                    ]));
          }

          return Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  padding:
                                      EdgeInsets.all(defaultPadding * 0.75),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: defaultPadding / 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: SvgPicture.asset(
                                      "assets/icons/Search.svg",
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
                      ])
                    ]),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Questions",
                  style: TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, NEW_QUESTION_FORM,
                            arguments: Question(
                                field:
                                    QuestionField(key: "", type: "", label: ""),
                                name: ""));
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add New"),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical: defaultPadding /
                                (Responsive.isMobile(context) ? 2 : 1),
                          ),
                          backgroundColor: primaryColor),
                    )
                  ],
                ),
                SizedBox(
                    width: double.infinity,
                    height: _screen.height / 1.4,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: EdgeInsets.all(defaultPadding),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.green),
                        child: DataTable2(
                          dataRowHeight: 60,
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
                            list.length,
                            (index) =>
                                templatesDataRow(list[index], _screen, context),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          );
        });
  }
}

DataRow templatesDataRow(
    Question questionInfo, Size screenSize, BuildContext context) {
  return DataRow(
    onSelectChanged: (selected) {
      Navigator.pushNamed(context, NEW_QUESTION_FORM, arguments: questionInfo);
    },
    cells: [
      DataCell(Container(
        width: (screenSize.width / 10) * 3,
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              SvgPicture.asset(
                "assets/icons/xd_file.svg",
                height: 30,
                width: 30,
              ),
            SizedBox(width: 5),
            Expanded(
              child: Text(questionInfo.name, style: textStyle),
            ),
          ],
        ),
      )),
      DataCell(Row(children: [
        Expanded(child: Text(questionInfo.dateCreated!, style: textStyle))
      ])),
      DataCell(Row(children: [
        Expanded(child: Text(questionInfo.departament!, style: textStyle))
      ])),
    ],
  );
}
