import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/database/models/studentModel.dart';
import 'package:student_records/Screens/homeScreen/input_page.dart';

ValueNotifier<List<StudentModel>> studentNotifier = ValueNotifier([]);
List<StudentModel> studenList = [];
Future<void> addStudent(StudentModel student) async {
  final stuDB = await Hive.openBox<StudentModel>('student_db');
  await stuDB.put(student.id, student);
  getAllData();
}

Future<void> getAllData() async {
  final stuDB = await Hive.openBox<StudentModel>('student_db');
  studentNotifier.value.clear();
  studentNotifier.value.addAll(stuDB.values);
  studenList.addAll(stuDB.values);
  studentNotifier.notifyListeners();
}

Future<void> deleteStudent(StudentModel student) async {
  final stuDB = await Hive.openBox<StudentModel>('student_db');
  await stuDB.delete(student.id);
  getAllData();
}

Future<void> updateStudent(StudentModel studentM) async {
  final stuDB = await Hive.openBox<StudentModel>('student_db');
  final student = stuDB.get(studentM.id);
  if (student?.name != studentM.name) {
    student?.name = studentM.name;
  }
  if (student?.age != studentM.age) {
    student?.age = studentM.age;
  }
  if (student?.phone != studentM.phone) {
    student?.phone = studentM.phone;
  }
  if (student?.mail != studentM.mail) {
    student?.mail = studentM.mail;
  }
  if (student?.imgPath != studentM.imgPath) {
    student?.imgPath = studentM.imgPath;
  }
  await stuDB.put(studentM.id, student!);
  getAllData();
}

Future<List<StudentModel>> getSearch() async {
  final stuDB = await Hive.openBox<StudentModel>('student_db');
  List<StudentModel> studentList = [];
  studentList.addAll(stuDB.values);
  return studentList;
}

// Future<void> search(String name) async {
//   modelListToMap();
//   if (name.isEmpty) {
//     mapStu.value = s;
//   } else {
//     mapStu.value = s.where((s) => false);
//   }
// }

// Future<void> modelListToMap() async {
//   final stuDB = await Hive.openBox<StudentModel>('student_db');
//   List<StudentModel> student = stuDB.values.toList();

//   for (var i in student) {
//     s.add({
//       'name': i.name,
//       'age': i.age,
//       'email': i.mail,
//       'phone': i.phone,
//       'id': i.id,
//       'img': i.imgPath
//     });
//   }
// }
