import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/presentation/Widgets/input_field_widget.dart';
import 'package:student_records/application/home_screen/home_screen_controller.dart';
import 'package:student_records/application/input_form_screen/input_form_screen_controllers.dart';
import 'package:student_records/domain/home_screen/models/student_model.dart';
import 'package:student_records/infrastructure/input_form_screen/input_screen_service_implementation.dart';

InputFormScreenController inputScreenController =
    Get.put(InputFormScreenController());

class InputPage extends StatelessWidget {
  InputPage({super.key});

  final formkey = GlobalKey<FormState>();

  Future<void> pickImage() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      inputScreenController.setPickedImage(imagePicked.path, true);
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
    inputScreenController.setPickedImage('', false);
    HomeScreenController controller = Get.put(HomeScreenController());
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
                    onTap: () async => await pickImage(),
                    child: CircleAvatar(
                      radius: 62,
                      backgroundColor: Colors.black54,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(60),
                            child: Obx(() {
                              if (inputScreenController.isPicked.value) {
                                File img =
                                    File(inputScreenController.imagePath.value);
                                return Image.file(img);
                              } else {
                                return Image.asset('assets/images/user.png');
                              }
                            }),
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
                                  imgPath:
                                      inputScreenController.imagePath.value);
                              input.addStudent(student);
                              controller.getAllStudentsDetails();
                              clearPage();
                              
                              Get.back();
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
