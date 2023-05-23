// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/application/home_screen/home_screen_bloc.dart';
import 'package:student_records/application/input_screen/input_screen_bloc.dart';
import 'package:student_records/presentation/Widgets/input_field_widget.dart';
import 'package:student_records/domain/home_screen/models/student_model.dart';
import 'package:student_records/presentation/home_screen/home_screen.dart';

class InputBottonSheet extends StatelessWidget {
  final StudentModel student;

  InputBottonSheet({super.key, required this.student});
  File? image;
  Future<void> pickImage(BuildContext context) async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      image = File(imagePicked.path);
      context.read<InputScreenBloc>().add(ImagePicked());
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();

  void setOldValuesToControllers() {
    // studentListController.updateImage(student.imgPath!, false);
    nameController.text = student.name;
    ageController.text = student.age;
    phoneEditingController.text = student.phone;
    emailEditingController.text = student.mail;
  }

  @override
  Widget build(BuildContext context) {
    //inputScreenController.setPickedImage('', false);
    setOldValuesToControllers();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(shrinkWrap: true, children: [
              const SizedBox(
                height: 6,
              ),
              InputFieldWidget(
                inputController: nameController,
                label: 'Name',
                type: TextInputType.name,
              ),
              const SizedBox(
                height: 6,
              ),
              InputFieldWidget(
                inputController: ageController,
                label: 'Age',
                type: TextInputType.number,
              ),
              const SizedBox(
                height: 6,
              ),
              InputFieldWidget(
                inputController: phoneEditingController,
                label: 'Phone Number',
                type: TextInputType.phone,
              ),
              const SizedBox(
                height: 6,
              ),
              InputFieldWidget(
                inputController: emailEditingController,
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
                      pickImage(context);
                    },
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.add_a_photo),
                        ),
                        const Text('Change Photo'),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black54,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 18,
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                  size: const Size.fromRadius(60),
                                  child: BlocBuilder<InputScreenBloc,
                                      InputScreenState>(
                                    builder: (context, state) {
                                      if (state.isImageSelected) {
                                        return Image.file(image!);
                                      } else {
                                        if (student.imgPath != '') {
                                          File? _image = File(student.imgPath!);
                                          return Image.file(_image);
                                        } else {
                                          return Image.asset(
                                              'assets/images/user.png');
                                        }
                                      }
                                    },
                                  )),
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
                                imgPath: image == null
                                    ? student.imgPath
                                    : image?.path,
                                age: ageController.text,
                                name: nameController.text,
                                mail: emailEditingController.text,
                                phone: phoneEditingController.text);
                            dataBaseFuctions.updateStudent(stu, student.key);
                            context
                                .read<HomeScreenBloc>()
                                .add(GetAllStudents());
                            Navigator.of(context).pop();
                          },
                          child: const Text('Update Details')),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
