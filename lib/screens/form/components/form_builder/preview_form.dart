import 'package:admin/constants.dart';
import 'package:admin/models/Question.dart';
import 'package:admin/service/form_builder_service.dart';
import 'package:flutter/material.dart';

class PreviewForm extends StatefulWidget {
  final Question question;
  const PreviewForm({Key? key, required this.question}) : super(key: key);

  @override
  _PreviewFormState createState() => _PreviewFormState();
}

class _PreviewFormState extends State<PreviewForm> {
  FormBuilderService formService = FormBuilderService();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
        child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            "Preview",
            style: titleStyle,
          ),
        ),
        Container(
          width: screenSize.width / 2,
          height: screenSize.height / 4,
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 3),
              color: Colors.white),
          child: Center(child: formService.inputPreview(widget.question)),
        )
      ],
    ));
  }
}