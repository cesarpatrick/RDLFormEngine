import 'package:admin/models/Template.dart';
import 'package:admin/screens/main/components/header.dart';
import 'package:admin/service/template_service.dart';
import 'package:admin/util.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class TemplatesScreen extends StatefulWidget {
  const TemplatesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _TemplatesScreenState createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  List<DropdownMenuItem<String>> departamentTypeDropDownItemList =
      Util.getDepartamentsDropdownMenu();

  TextEditingController searchValueController = TextEditingController();

  String _departamentDropdownValue = "";

  ScrollController scrollController = ScrollController();

  TemplateService api = TemplateService();

  late Future<List<Template>> templateList = api.getTemplates();

  @override
  void initState() {
    super.initState();
  }

  void filter() {
    Template template = Template(
        name: searchValueController.text,
        departament: _departamentDropdownValue,
        questions: []);

    templateList = api.getTemplatesFilter(template);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size _screen = MediaQuery.of(context).size;

    return FutureBuilder<List<Template>>(
        future: templateList,
        builder: (context, snapshot) {
          List<Template> list = List<Template>.empty();

          if (snapshot.hasData) {
            list = snapshot.data!;
          } else {
            //todo: Break this down into a widget that way dont need to copy the code twice
            return Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(children: <Widget>[
                          Container(
                              width: _screen.width / 6,
                              child: Center(
                                  child: TextField(
                                      controller: searchValueController,
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
                                          onTap: () {
                                            setState(() {
                                              filter();
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                defaultPadding * 0.75),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: defaultPadding / 2),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
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
                                filter();
                              });
                            },
                            items: departamentTypeDropDownItemList,
                          )
                        ]),
                      ]),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Forms",
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
                          Navigator.pushNamed(context, NEW_TEMPLATE_FORM,
                              arguments: Template(questions: [], name: ""));
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
                ],
              ),
            );
          }

          return Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: secondaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(children: <Widget>[
                        Container(
                            width: _screen.width / 6,
                            child: Center(
                                child: TextField(
                                    controller: searchValueController,
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
                                        onTap: () {
                                          setState(() {
                                            filter();
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              defaultPadding * 0.75),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: defaultPadding / 2),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
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
                              filter();
                            });
                          },
                          items: departamentTypeDropDownItemList,
                        )
                      ]),
                    ]),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Forms",
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
                        Navigator.pushNamed(context, NEW_TEMPLATE_FORM,
                            arguments: Template(questions: [], name: ""));
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
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: _screen.height / 1.4,
                  child: Theme(
                    data:
                        Theme.of(context).copyWith(dividerColor: Colors.green),
                    child: DataTable2(
                      showCheckboxColumn: false,
                      columnSpacing: defaultPadding,
                      dataRowHeight: 60,
                      headingRowColor: MaterialStateProperty.all(primaryColor),
                      headingTextStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      columns: [
                        DataColumn(
                          label: Text(
                            "Name",
                          ),
                        ),
                        DataColumn(
                          label: Text("Date"),
                        ),
                        DataColumn(
                          label: Text("Departament"),
                        ),
                      ],
                      rows: List.generate(
                        list.length,
                        (index) =>
                            templatesDataRow(list[index], _screen, context),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  DataRow templatesDataRow(
      Template templateInfo, Size screenSize, BuildContext context) {
    return DataRow(
      onSelectChanged: (selected) {
        Navigator.pushNamed(context, NEW_TEMPLATE_FORM,
            arguments: templateInfo);
      },
      cells: [
        DataCell(Container(
          width: (screenSize.width / 10) * 3,
          child: Row(children: [
            if (Responsive.isDesktop(context))
              SvgPicture.asset(
                "assets/icons/xd_file.svg",
                height: 30,
                width: 30,
              ),
            SizedBox(width: 5),
            Expanded(
              child: Text(templateInfo.name, style: textStyle),
            ),
          ]),
        )),
        DataCell(Row(children: [
          Expanded(child: Text(templateInfo.dateCreated!, style: textStyle))
        ])),
        DataCell(Row(children: [
          Expanded(child: Text(templateInfo.departament!, style: textStyle))
        ])),
      ],
    );
  }
}
