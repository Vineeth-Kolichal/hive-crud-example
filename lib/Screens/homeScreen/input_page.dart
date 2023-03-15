import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/database/models/studentModel.dart';
import 'package:student_records/database/functions/db_functions.dart';
import 'package:student_records/Widgets/input_field_widget.dart';

// ignore: must_be_immutable
class InputPage extends StatefulWidget {
  String? name;
  String? age;
  String? phone;
  String? email;
  String? imgPath;
  InputPage.update({
    super.key,
    this.name,
    this.age,
    this.email,
    this.imgPath,
    this.phone,
  }) {
    _InputPageState.update(
      name: name,
      age: age,
      phone: phone,
      mail: email,
      imgPath: imgPath,
    );
  }
  InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  _InputPageState();
  String? name;
  String? age;
  String? phone;
  String? mail;
  String? imgPath;
  _InputPageState.update(
      {this.name, this.age, this.phone, this.mail, this.imgPath}) {
    setOnUpdate();
  }
  final formkey = GlobalKey<FormState>();

  File? _image;
  Future<void> pickImage() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        _image = File(imagePicked.path);
        //print(imagePicked.path);
      });
    }
  }

  void clearPage() {
    _nameController.text = 'hai';
    _ageController.text = '';
    _emailEditingController.text = '';
    _phoneEditingController.text = '';
  }

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  void setOnUpdate() {
    _nameController.text = name!;
    _ageController.text = age!;
    _phoneEditingController.text = phone!;
    _emailEditingController.text = mail!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter student details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () => pickImage(),
                    child: CircleAvatar(
                      radius: 62,
                      backgroundColor: Colors.black54,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
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
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputFieldWidget(
                      inputController: _nameController,
                      label: 'Name',
                      type: TextInputType.name),
                  InputFieldWidget(
                      inputController: _ageController,
                      label: 'Age',
                      type: TextInputType.number),
                  InputFieldWidget(
                      inputController: _phoneEditingController,
                      label: 'Phone',
                      type: TextInputType.phone),
                  InputFieldWidget(
                      inputController: _emailEditingController,
                      label: 'e-mail',
                      type: TextInputType.emailAddress),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: const ButtonStyle(),
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();
                                StudentModel student = StudentModel(
                                    age: _ageController.text,
                                    name: _nameController.text,
                                    phone: _phoneEditingController.text,
                                    mail: _emailEditingController.text,
                                    id: DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    imgPath: _image?.path ?? 'no-img');
                                addStudent(student);

                                Navigator.of(context).pop();
                                getAllData();
                                // clearPage();
                              }
                            },
                            child: const Text('Save Details')),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
