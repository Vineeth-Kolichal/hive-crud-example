import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/domain/home_screen/models/student_model.dart';
import 'package:student_records/domain/input_form_screen/input_form_screen_services.dart';
import 'package:student_records/presentation/home_screen/home_screen.dart';

class InputFormSecreenServiceImplementation extends InputScreenServices {
  @override
  Future<void> addStudent(StudentModel student) async {
    final stuDB = await Hive.openBox<StudentModel>('student_db');
    await stuDB.add(student);
    studentListController.getAllStudentsDetails();
  }
}
