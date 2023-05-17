import 'package:hive_flutter/hive_flutter.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String age;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String mail;

  @HiveField(4)
  String? imgPath;

  StudentModel(
      {required this.name,
      required this.age,
      required this.phone,
      required this.mail,
      this.imgPath});
}
