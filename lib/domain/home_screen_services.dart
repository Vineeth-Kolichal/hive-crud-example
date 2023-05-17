import 'package:student_records/domain/home_screen/models/student_model.dart';

abstract class HomeScreenServices {
  Future<void> addStudent(StudentModel student);
  Future<List<StudentModel>> getAllData();
  Future<void> deleteStudent(int id);
  Future<void> updateStudent(StudentModel student,int key);
}
