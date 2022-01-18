import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class InputsInfoModal extends StatefulWidget {
  const InputsInfoModal({Key? key}) : super(key: key);

  @override
  _InputsInfoModalState createState() => _InputsInfoModalState();
}

class _InputsInfoModalState extends State<InputsInfoModal> {
  @override
  Widget build(BuildContext context) {
    bool initialValueSwitch = false;
    ScrollController scrollController = ScrollController();
    int? _groupValue = 1;
    int? value = 1;

    Size screenSize = MediaQuery.of(context).size;

    return Dialog(
        child: Container(
            color: primaryColor,
            width: screenSize.width / 1.5,
            height: screenSize.height / 1.5,
            child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "Help",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                            Column(children: <Widget>[
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'This is a Switch input',
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Switch(
                                activeColor: Colors.blue[900],
                                value: initialValueSwitch,
                                onChanged: (value) {},
                              )
                            ]),
                            const Text(
                              'This is a Text input',
                              style: TextStyle(fontSize: 14),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: 'Label',
                                    hintText: 'Enter the label'),
                              ),
                            ),
                            const Text(
                              'This is a Text Area input',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                            height: 200,
                                            width: screenSize.width / 1.6,
                                            child: TextField(
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: new InputDecoration(
                                                  fillColor: primaryColor,
                                                  filled: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 0.5,
                                                    ),
                                                  ),
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(25.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                  //fillColor: Colors.green
                                                  ),
                                              minLines:
                                                  5, // any number you need (It works as the rows for the textarea)
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                            )),
                                      ],
                                    )),
                              ],
                            ),
                            Column(children: [
                              const Text(
                                'This is a Radio Button input',
                                style: TextStyle(fontSize: 14),
                              ),
                              RadioListTile(
                                value: 1,
                                groupValue: value,
                                onChanged: (value) {
                                  setState(() {
                                    value = value;
                                  });
                                },
                                title: Text("Option 1"),
                              ),
                              RadioListTile(
                                value: 2,
                                groupValue: value,
                                onChanged: (value) {
                                  setState(() {
                                    value = value;
                                  });
                                },
                                title: Text("Option 2"),
                              ),
                              RadioListTile(
                                value: 3,
                                groupValue: value,
                                onChanged: (value) {
                                  setState(() {
                                    value = value;
                                  });
                                },
                                title: Text("Option 3"),
                              )
                            ]),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () =>
                                      {Navigator.of(context).pop()},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                  ),
                                  child: RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "Close",
                                            style:
                                                TextStyle(color: Colors.white))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ))
                  ],
                ))));
  }
}