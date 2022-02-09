import 'package:admin/constants.dart';
import 'package:admin/models/Question.dart';
import 'package:admin/models/Template.dart';
import 'package:admin/screens/main/components/header.dart';
import 'package:admin/service/form_builder_service.dart';
import 'package:admin/util.dart';
import 'package:flutter/material.dart';

import 'template_form_builder.dart';

class NewTemplateForm extends StatefulWidget {
  final Template? template;
  const NewTemplateForm({Key? key, this.template}) : super(key: key);

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

  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    initialValueSwitch = false;

    if (widget.template!.id != null && widget.template!.id != 0) {
      nameController.text = widget.template!.name;
      _departamentDropdownValue = widget.template!.departament!;
      name = widget.template!.name;
      questions = widget.template!.questions;
    }
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
                              "New Form",
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
                        if (name != "")
                          Theme(
                              data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.black,
                                  disabledColor: Colors.black),
                              child: TemplateFormBuilder(
                                  name: name,
                                  departament: _departamentDropdownValue,
                                  questions: questions,
                                  templateId: widget.template!.id))
                      ],
                    ))
              ],
            )));
  }
}
