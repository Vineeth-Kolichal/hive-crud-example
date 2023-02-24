import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/Database/Models/studentModel.dart';
import 'package:student_records/Database/boxes.dart';
import 'package:student_records/Screens/HomeScreen/inputPage.dart';

ValueNotifier<List<StudentModel>> studentNotifier = ValueNotifier([]);
Future<void> addStudent(
    {required String sname,
    required String sage,
    required String sphone,
    required String semail,
    String? simgPro}) async {
  final user = StudentModel()
    ..name = sname
    ..age = sage
    ..phone = sphone
    ..mail = semail
    ..imgPath = simgPro;

  final box = Boxes.getUsers();
  box.add(user);
  getAllData();
}

Future<List<StudentModel>> getAllData() async {
  final box = await Hive.box<StudentModel>('student_db');
  final student = box.values.toList();
  studentNotifier.value.clear();
  studentNotifier.value.addAll(box.values);
  studentNotifier.notifyListeners();
  return student;
}

Future<void> deleteStudent(StudentModel studMo) async {
  await studMo.delete();
  getAllData();
}

Future<void> updateStudent(StudentModel studMo,BuildContext context) async {
  String name = studMo.name;
  String age = studMo.age;
  String phone = studMo.phone;
  String mail = studMo.mail;
  String? imgPath = studMo.imgPath;
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => InputPage.update(
      name: name,
      age: age,
      email: mail,
      phone: phone,
      imgPath: imgPath,
    ),
  ));
  // InputPage.update(
  //   name: name,
  //   age: age,
  //   email: mail,
  //   phone: phone,
  //   imgPath: imgPath,
  // );
  await studMo.delete();
}
