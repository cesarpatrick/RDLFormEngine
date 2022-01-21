import 'package:admin/models/ListTemplate.dart';
import 'package:admin/screens/main/components/header.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class Templates extends StatelessWidget {
  const Templates({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, NEW_TEMPLATE_FORM);
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
              ]),
          SizedBox(
            height: 20,
          ),
          Text(
            "Templates",
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

DataRow templatesDataRow(ListTemplate templateInfo) {
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
