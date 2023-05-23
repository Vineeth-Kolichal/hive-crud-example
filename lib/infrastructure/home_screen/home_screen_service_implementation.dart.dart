import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/domain/home_screen/models/student_model.dart';
import 'package:student_records/domain/home_screen/home_screen_services.dart';

class HomeScreenServicesImplementation extends HomeScreenServices {
  static final HomeScreenServicesImplementation dataBaseFuctions =
      HomeScreenServicesImplementation._internal();
  factory HomeScreenServicesImplementation() {
    return dataBaseFuctions;
  }
  List<StudentModel> studenList = [];

  @override
  Future<List<StudentModel>> getAllData(String query) async {
    final stuDB = await Hive.openBox<StudentModel>('student_db');
    List<StudentModel> students = [];
    log(query);
    students.addAll(stuDB.values
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase().trim()))
        .toList());
    return students;
  }

  @override
  Future<void> deleteStudent(int id) async {
    final stuDB = await Hive.openBox<StudentModel>('student_db');
    await stuDB.delete(id);
    //studentListController.getAllStudentsDetails();
  }

  @override
  Future<void> updateStudent(StudentModel student, int key) async {
    final stuDB = await Hive.openBox<StudentModel>('student_db');
    await stuDB.put(key, student);
   // studentListController.getAllStudentsDetails();
  }
  HomeScreenServicesImplementation._internal();
}
