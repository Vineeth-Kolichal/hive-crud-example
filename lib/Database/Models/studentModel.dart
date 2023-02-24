import 'package:hive_flutter/hive_flutter.dart';
part 'studentModel.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String age;

  @HiveField(2)
  late String phone;

  @HiveField(3)
  late String mail;

  @HiveField(4)
  late String? imgPath;

  // StudentModel(
  //     {required this.name,
  //     required this.age,
  //     required this.phone,
  //     required this.mail,
  //     this.imgPath});
}
