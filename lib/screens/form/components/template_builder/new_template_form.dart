import 'package:admin/constants.dart';
import 'package:admin/screens/main/components/header.dart';
import 'package:admin/service/form_builder_service.dart';
import 'package:admin/util.dart';
import 'package:flutter/material.dart';

import 'template_form_builder.dart';

class NewTemplateForm extends StatefulWidget {
  const NewTemplateForm({Key? key}) : super(key: key);

  @override
  _NewTemplateFormState createState() => _NewTemplateFormState();
}

class _NewTemplateFormState extends State<NewTemplateForm> {
  bool initialValueSwitch = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController initialValueController = TextEditingController();

  FormBuilderService builderService = FormBuilderService();

  ScrollController scrollController = ScrollController();

  List<DropdownMenuItem<String>> departamentTypeDropDownItemList =
      Util.getDepartamentsDropdownMenu();

  String name = "";
  String _departamentDropdownValue = "";

  bool _validate = false;

  @override
  void initState() {
    super.initState();
    initialValueSwitch = false;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    initialValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _screen = MediaQuery.of(context).size;

    return Container(
        color: Colors.white,
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Header(),
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Column(children: [
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "New Template",
                              style: titleStyle,
                            ),
                          )
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 4,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: primaryColor,
                                    border: const OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    hintText: 'Enter the name',
                                    errorText: _validate
                                        ? 'Name Can\'t Be Empty'
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text("Departament", style: textStyle)),
                              Flexible(
                                  flex: 2,
                                  child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        icon: Icon(
                                          // Add this
                                          Icons.arrow_drop_down, // Add this
                                          color: primaryColor, // Add this
                                        ),
                                        value: _departamentDropdownValue,
                                        style: const TextStyle(
                                            color: primaryColor),
                                        dropdownColor: Colors.white,
                                        underline: Container(
                                          height: 2,
                                          color: primaryColor,
                                        ),
                                        onChanged: (newValue) {
                                          setState(() {
                                            _departamentDropdownValue =
                                                newValue!;
                                          });
                                        },
                                        items: departamentTypeDropDownItemList,
                                      )))
                            ]),
                        horizontalDivider,
                        Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.black,
                                disabledColor: Colors.black),
                            child: TemplateFormBuilder(
                              name: name,
                            ))
                      ],
                    ))
              ],
            )));
  }
}
