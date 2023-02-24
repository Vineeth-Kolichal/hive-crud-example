import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/Database/Models/studentModel.dart';
import 'package:student_records/Screens/HomeScreen/homeScreen.dart';

const Save_key_name = 'logged_in';
Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
    await Hive.openBox<StudentModel>('student_db');
  }
  runApp(StudentRecord());
}

class StudentRecord extends StatelessWidget {
  const StudentRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      home: HomeScreen(),
    );
  }
}
