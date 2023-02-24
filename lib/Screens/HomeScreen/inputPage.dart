import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/Database/functions/db_functions.dart';
import 'package:student_records/Widgets/inputFieldWidget.dart';

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
    try {
      final imagePicked =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagePicked != null) {
        setState(() {
          _image = File(imagePicked.path);
        });
      }
    } on PlatformException catch (e) {}
  }

  void clearPage() {
    _nameController.text = '';
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
    print(_nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 62,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60,
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(60),
                              child: (_image != null)
                                  ? Image.file(
                                      _image! ,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset('assets/images/user.png'),
                            ),
                          ),
                        ),
                        backgroundColor: Colors.black54,
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.black45,
                            child: IconButton(
                              onPressed: () {
                                pickImage();
                              },
                              icon: Icon(Icons.add_a_photo),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ButtonStyle(),
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  formkey.currentState!.save();
                                  print(_nameController.text);
                                  addStudent(
                                      sname: _nameController.text,
                                      sage: _ageController.text,
                                      sphone: _phoneEditingController.text,
                                      semail: _emailEditingController.text,
                                      simgPro: _image?.path ?? '');
                                  Navigator.of(context).pop();
                                  getAllData();
                                  clearPage();
                                }
                              },
                              child: Text('Save Details')),
                        ),
                      ],
                    ),
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
