import 'package:admin/constants.dart';
import 'package:admin/screens/main/components/header.dart';
import 'package:admin/service/form_builder_service.dart';
import 'package:admin/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "New Template",
                            style: titleStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextField(
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
                              errorText:
                                  _validate ? 'Name Can\'t Be Empty' : null,
                            ),
                          ),
                        ),
                        horizontalDivider,
                        Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.black,
                                disabledColor: Colors.black),
                            child: TemplateFormBuilder())
                      ],
                    ))
              ],
            )));
  }
}
