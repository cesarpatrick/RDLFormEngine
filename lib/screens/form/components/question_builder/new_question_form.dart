import 'package:admin/constants.dart';
import 'package:admin/models/Question.dart';
import 'package:admin/screens/main/components/header.dart';
import 'package:admin/service/form_builder_service.dart';
import 'package:admin/util.dart';
import 'package:flutter/material.dart';

import 'inputs_info_modal.dart';

class NewQuestionForm extends StatefulWidget {
  final Question? question;
  const NewQuestionForm({Key? key, this.question}) : super(key: key);

  @override
  _NewQuestionFormState createState() => _NewQuestionFormState();
}

class _NewQuestionFormState extends State<NewQuestionForm> {
  bool initialValueSwitch = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController initialValueController = TextEditingController();

  FormBuilderService builderService = FormBuilderService();

  bool _validate = false;

  String nameValue = "";
  String _typeDropdownValue = "";
  String _departamentDropdownValue = "";

  @override
  void initState() {
    super.initState();
    initialValueSwitch = false;
    if (widget.question!.id != null && widget.question!.id != 0) {
      nameController.text = widget.question!.name;
      _departamentDropdownValue = widget.question!.departament!;
      _typeDropdownValue = widget.question!.field!.type;
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    initialValueController.dispose();
    super.dispose();
  }

  _validateForm() {
    if (nameController.text.isEmpty) {
      setState(() => _validate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> inputTypeDropDownItemList =
        Util.getInputDropdownMenu();

    List<DropdownMenuItem<String>> departamentTypeDropDownItemList =
        Util.getDepartamentsDropdownMenu();

    return Container(
        color: Colors.white,
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Header(),
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "New Question",
                            style: titleStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {});
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
                              errorText:
                                  _validate ? 'Name Can\'t Be Empty' : null,
                            ),
                          ),
                        ),
                        Row(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text("Departament", style: textStyle)),
                          Flexible(
                              flex: 4,
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
                                    style: const TextStyle(color: primaryColor),
                                    dropdownColor: Colors.white,
                                    underline: Container(
                                      height: 2,
                                      color: primaryColor,
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _validateForm();
                                        _departamentDropdownValue = newValue!;
                                      });
                                    },
                                    items: departamentTypeDropDownItemList,
                                  ))),
                          Text("Input Type", style: textStyle),
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
                                    value: _typeDropdownValue,
                                    style: const TextStyle(color: primaryColor),
                                    dropdownColor: Colors.white,
                                    underline: Container(
                                      height: 2,
                                      color: primaryColor,
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _validateForm();
                                        _typeDropdownValue = newValue!;
                                      });
                                    },
                                    items: inputTypeDropDownItemList,
                                  ))),
                          IconButton(
                            tooltip: "Help",
                            color: Colors.red,
                            icon: new Icon(Icons.info_sharp),
                            highlightColor: Colors.redAccent,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const InputsInfoModal();
                                  });
                            },
                          )
                        ]),
                        horizontalDivider,
                        if (nameController.text != "")
                          builderService.getFormByInputType(
                              nameController.text,
                              _typeDropdownValue,
                              _departamentDropdownValue,
                              widget.question!)
                      ],
                    )))
              ],
            )));
  }
}
