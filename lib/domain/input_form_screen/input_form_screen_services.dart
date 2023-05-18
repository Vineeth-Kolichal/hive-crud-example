
import 'package:student_records/domain/home_screen/models/student_model.dart';

abstract class InputScreenServices{
   Future<void> addStudent(StudentModel student);
}