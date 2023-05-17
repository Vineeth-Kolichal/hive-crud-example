import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/domain/home_screen/models/student_model.dart';
import 'package:student_records/domain/home_screen_services.dart';
import 'package:student_records/presentation/home_screen/home_screen.dart';

class HomeScreenServicesImplementation extends HomeScreenServices {
  static final HomeScreenServicesImplementation dataBaseFuctions =
      HomeScreenServicesImplementation._internal();
  factory HomeScreenServicesImplementation() {
    return dataBaseFuctions;
  }
  List<StudentModel> studenList = [];
  @override
  Future<void> addStudent(StudentModel student) async {
    final stuDB = await Hive.openBox<StudentModel>('student_db');
    await stuDB.add(student);
    studentListController.getAllStudentsDetails();
  }

  @override
  Future<List<StudentModel>> getAllData() async {
    final stuDB = await Hive.openBox<StudentModel>('student_db');
    List<StudentModel> students = [];
    students.addAll(stuDB.values);
    return students;
  }

  @override
  Future<void> deleteStudent(int id) async {
    final stuDB = await Hive.openBox<StudentModel>('student_db');
    await stuDB.delete(id);
    studentListController.getAllStudentsDetails();
  }

  @override
  Future<void> updateStudent(StudentModel student, int key) async {
    final stuDB = await Hive.openBox<StudentModel>('student_db');
    await stuDB.put(key, student);
    studentListController.getAllStudentsDetails();
  }

  Future<List<StudentModel>> getSearch() async {
    final stuDB = await Hive.openBox<StudentModel>('student_db');
    List<StudentModel> studentList = [];
    studentList.addAll(stuDB.values);
    return studentList;
  }

  HomeScreenServicesImplementation._internal();
}
