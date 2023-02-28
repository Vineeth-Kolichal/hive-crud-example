import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/database/Models/studentModel.dart';
import 'package:student_records/Screens/HomeScreen/inputPage.dart';

ValueNotifier<List<StudentModel>> studentNotifier = ValueNotifier([]);
Future<void> addStudent(StudentModel student) async {
  final stuDB = await Hive.openBox<StudentModel>('student_db');
  await stuDB.put(student.id, student);
  getAllData();
}

Future<void> getAllData() async {
  final stuDB = await Hive.openBox<StudentModel>('student_db');
  studentNotifier.value.clear();
  studentNotifier.value.addAll(stuDB.values);
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
