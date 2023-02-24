import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:student_records/Screens/HomeScreen/homeScreen.dart';

const Save_key_name = 'logged_in';
void main(List<String> args) {
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
