import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/application/home_screen/home_screen_bloc.dart';
import 'package:student_records/application/input_screen/input_screen_bloc.dart';
import 'package:student_records/presentation/Widgets/input_field_widget.dart';
import 'package:student_records/domain/home_screen/models/student_model.dart';
import 'package:student_records/infrastructure/input_form_screen/input_screen_service_implementation.dart';

// ignore: must_be_immutable
class InputPage extends StatelessWidget {
  InputPage({super.key});

  final formkey = GlobalKey<FormState>();
  File? image;
  Future<void> pickImage(BuildContext context) async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      image = File(imagePicked.path);
      context.read<InputScreenBloc>().add(ImagePicked());
    }
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

  @override
  Widget build(BuildContext context) {
    InputFormSecreenServiceImplementation input =
        InputFormSecreenServiceImplementation();
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
                    onTap: () async => await pickImage(context),
                    child: CircleAvatar(
                      radius: 62,
                      backgroundColor: Colors.black54,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(60),
                            child:
                                BlocBuilder<InputScreenBloc, InputScreenState>(
                              builder: (context, state) {
                                if (state.isImageSelected) {
                                  return Image.file(image!);
                                } else {
                                  return Image.asset('assets/images/user.png');
                                }
                              },
                            ),
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
                                  imgPath: image != null ? image?.path : '');
                              input.addStudent(student);
                              clearPage();
                              context
                                  .read<HomeScreenBloc>()
                                  .add(GetAllStudents());
                              Navigator.of(context).pop();
                              // dataBaseFuctions.getAllData();
                            }
                          },
                          child: const Text('Save Details'),
                        ),
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
