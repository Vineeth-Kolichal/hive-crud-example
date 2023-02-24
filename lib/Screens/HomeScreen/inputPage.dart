import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/Widgets/inputFieldWidget.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
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
      // final imageTemp = (File(image.path));
      // setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {}
  }

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      // child: Image.file(_image!),
                      backgroundImage: AssetImage('assets/images/user.png'),
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
                    inputController: _nameController,
                    label: 'Age',
                    type: TextInputType.name),
                InputFieldWidget(
                    inputController: _nameController,
                    label: 'Phone',
                    type: TextInputType.name),
                InputFieldWidget(
                    inputController: _nameController,
                    label: 'e-mail',
                    type: TextInputType.name),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
