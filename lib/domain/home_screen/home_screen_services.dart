import 'package:student_records/domain/home_screen/models/student_model.dart';

abstract class HomeScreenServices {
  Future<List<StudentModel>> getAllData(String query);
  Future<void> deleteStudent(int id);
  Future<void> updateStudent(StudentModel student,int key);
}
