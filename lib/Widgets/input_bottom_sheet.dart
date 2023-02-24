import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:student_records/Widgets/inputFieldWidget.dart';

class InputBottonSheet extends StatefulWidget {
  const InputBottonSheet({super.key});

  @override
  State<InputBottonSheet> createState() => _InputBottonSheetState();
}

class _InputBottonSheetState extends State<InputBottonSheet> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        InputFieldWidget(
          inputController: _nameController,
          label: 'Name',
          type: TextInputType.name,
        ),
        const SizedBox(
          height: 10,
        ),
        InputFieldWidget(
          inputController: _ageController,
          label: 'Age',
          type: TextInputType.number,
        ),
        const SizedBox(
          height: 10,
        ),
        InputFieldWidget(
          inputController: _phoneEditingController,
          label: 'Phone Number',
          type: TextInputType.phone,
        ),
        const SizedBox(
          height: 10,
        ),
        InputFieldWidget(
          inputController: _emailEditingController,
          label: 'E-mail',
          type: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () {
                      print(_nameController.text);
                      Navigator.of(context).pop();
                    },
                    child: Text('Save Details')),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
