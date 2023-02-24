import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/Database/Models/studentModel.dart';

class Boxes {
  static Box<StudentModel> getUsers() => Hive.box('student_db');
}
