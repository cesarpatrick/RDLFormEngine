import 'package:admin/constants.dart';
import 'package:admin/screens/form/components/form_builder/inputs_info_modal.dart';
import 'package:admin/screens/main/components/header.dart';
import 'package:admin/service/form_builder_service.dart';
import 'package:admin/util.dart';
import 'package:flutter/material.dart';

class NewQuestionForm extends StatefulWidget {
  const NewQuestionForm({Key? key}) : super(key: key);

  @override
  _NewQuestionFormState createState() => _NewQuestionFormState();
}

class _NewQuestionFormState extends State<NewQuestionForm> {
  bool initialValueSwitch = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController initialValueController = TextEditingController();

  FormBuilderService builderService = FormBuilderService();

  ScrollController scrollController = ScrollController();

  bool _validate = false;

  String _typeDropdownValue = "";
  String _departamentDropdownValue = "";

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
                        controller: scrollController,
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
                              const SizedBox(
                                width: 20,
                              ),
                              Text("Departament", style: textStyle),
                              const SizedBox(
                                width: 20,
                              ),
                              DropdownButton<String>(
                                value: _departamentDropdownValue,
                                style: const TextStyle(color: primaryColor),
                                dropdownColor: Colors.white,
                                underline: Container(
                                  height: 2,
                                  color: Colors.black,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    _validateForm();
                                    _departamentDropdownValue = newValue!;
                                  });
                                },
                                items: departamentTypeDropDownItemList,
                              )
                            ]),
                            Row(children: <Widget>[
                              const SizedBox(
                                width: 20,
                              ),
                              Text("Input Type", style: textStyle),
                              const SizedBox(
                                width: 42,
                              ),
                              DropdownButton<String>(
                                value: _typeDropdownValue,
                                style: const TextStyle(color: primaryColor),
                                dropdownColor: Colors.white,
                                underline: Container(
                                  height: 2,
                                  color: Colors.black,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    _validateForm();
                                    _typeDropdownValue = newValue!;
                                  });
                                },
                                items: inputTypeDropDownItemList,
                              ),
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
                            builderService.getFormByInputType(
                                nameController.text,
                                _typeDropdownValue,
                                _departamentDropdownValue),
                          ],
                        )))
              ],
            )));
  }
}