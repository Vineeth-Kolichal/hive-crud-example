import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/Widgets/inputFieldWidget.dart';
import 'package:student_records/database/Models/studentModel.dart';
import 'package:student_records/database/functions/db_functions.dart';

class InputBottonSheet extends StatefulWidget {
  StudentModel student;
  InputBottonSheet({super.key, required this.student});

  @override
  State<InputBottonSheet> createState() =>
      _InputBottonSheetState(student: student);
}

class _InputBottonSheetState extends State<InputBottonSheet> {
  bool isImg = false;
  File? _image;
  Future<void> pickImage() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        _image = File(imagePicked.path);
        isImg = true;
      });
    }
  }

  StudentModel student;

  _InputBottonSheetState({required this.student});
  TextEditingController _nameController = TextEditingController();

  TextEditingController _ageController = TextEditingController();

  TextEditingController _phoneEditingController = TextEditingController();

  TextEditingController _emailEditingController = TextEditingController();
  @override
  void initState() {
    _nameController.text = student.name;
    _ageController.text = student.age;
    _phoneEditingController.text = student.phone;
    _emailEditingController.text = student.mail;
    // TODO: implement initState
    super.initState();
  }

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
        Row(
          children: [
            TextButton(
              onPressed: () {
                pickImage();
              },
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.add_a_photo),
                  ),
                  const Text('Change Photo'),
                  Visibility(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        color: Colors.green,
                        Icons.check,
                      ),
                    ),
                    visible: isImg,
                  )
                ],
              ),
            ),
          ],
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
                      StudentModel stu = StudentModel(
                          imgPath: _image?.path ?? student.imgPath,
                          id: student.id,
                          age: _ageController.text,
                          name: _nameController.text,
                          mail: _emailEditingController.text,
                          phone: _phoneEditingController.text);
                      print(_nameController.text);
                      updateStudent(stu);

                      Navigator.of(context).pop();
                    },
                    child: Text('Update Details')),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
