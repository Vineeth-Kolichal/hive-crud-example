// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/Widgets/input_field_widget.dart';
import 'package:student_records/domain/studentModel.dart';
import 'package:student_records/infrastructure/db_functions.dart';

class InputBottonSheet extends StatefulWidget {
  StudentModel student;
  InputBottonSheet({super.key, required this.student});

  @override
  State<InputBottonSheet> createState() =>
      // ignore: no_logic_in_create_state
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        const SizedBox(
          height: 6,
        ),
        InputFieldWidget(
          inputController: _nameController,
          label: 'Name',
          type: TextInputType.name,
        ),
        const SizedBox(
          height: 6,
        ),
        InputFieldWidget(
          inputController: _ageController,
          label: 'Age',
          type: TextInputType.number,
        ),
        const SizedBox(
          height: 6,
        ),
        InputFieldWidget(
          inputController: _phoneEditingController,
          label: 'Phone Number',
          type: TextInputType.phone,
        ),
        const SizedBox(
          height: 6,
        ),
        InputFieldWidget(
          inputController: _emailEditingController,
          label: 'E-mail',
          type: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 6,
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
                    visible: isImg,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black54,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18,
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(60),
                            child: (_image != null)
                                ? Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset('assets/images/user.png'),
                          ),
                        ),
                      ),
                    ),
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
                    onPressed: () {
                      StudentModel stu = StudentModel(
                          imgPath: _image?.path ?? student.imgPath,
                          id: student.id,
                          age: _ageController.text,
                          name: _nameController.text,
                          mail: _emailEditingController.text,
                          phone: _phoneEditingController.text);
                      updateStudent(stu);

                      Get.back();
                    },
                    child: const Text('Update Details')),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
