import 'dart:io';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/Screens/pages/search_page.dart';
import 'package:student_records/Widgets/animated_search_bar.dart';
import 'package:student_records/database/Models/studentModel.dart';
import 'package:student_records/database/functions/db_functions.dart';
import 'package:student_records/Screens/StudentDetials/detailed_view.dart';
import 'package:student_records/Screens/HomeScreen/inputPage.dart';
import 'package:student_records/Widgets/customSearchDelegate.dart';
import 'package:student_records/Widgets/input_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StudentModel> studentList = [];
  late List<StudentModel> studentDisplay = List<StudentModel>.from(studentList);
  // @override
  // void initState() {
  //   // final stuDB =  Hive.openBox<StudentModel>('student_db');
  //   // studentList.addAll(stuDB.values);

  //   studentDisplay = studentList;
  //   super.initState();
  // }

  // void searchStudent(String value) {
  //   setState(() {
  //     studentDisplay = studentList
  //         .where((element) =>
  //             element.name.toLowerCase().contains(value.trim().toLowerCase()))
  //         .toList();
  //   });
  // }

  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getAllData();
    return Scaffold(
      backgroundColor: Color.fromARGB(241, 243, 241, 241),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //SearchBar(),
                // SizedBox(
                //   width: double.infinity,
                //   height: 70,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: AnimSearchBar(
                //       rtl: true,
                //       onSubmitted: (p0) {
                //         // searchStudent(p0);
                //       },
                //       width: 400,
                //       textController: textController,
                //       onSuffixTap: () {
                //         textController.clear();
                //       },
                //     ),
                //   ),
                // ),
                Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: studentNotifier,
                      builder: (context, student, child) {
                        return ListView.separated(
                            itemBuilder: (ctx, index) {
                              StudentModel stu = student[index];
                              File? _image;
                              if (stu.imgPath != 'no-img') {
                                _image = File(stu.imgPath!);
                              }
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => DetaildView(
                                                name: stu.name,
                                                age: stu.age,
                                                phone: stu.phone,
                                                email: stu.mail,
                                                image: _image)));
                                  },
                                  title: Text(stu.name),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.black12,
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(20),
                                        child: (_image != null)
                                            ? Image.file(
                                                _image,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/images/user.png'),
                                      ),
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: 150,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            bottomSheet(context, stu);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            deleteAlert(
                                                context, student[index]);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemCount: student.length);
                      }),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InputPage(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return SearchPage();
                },
              ));
            },
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
        title: Text('Student List'),
      ),
    );
  }
}

Future<dynamic> bottomSheet(BuildContext context, StudentModel student) async {
  return await showModalBottomSheet(
      context: context,
      builder: ((BuildContext ctx) {
        return SizedBox(
          child: InputBottonSheet(
            student: student,
          ),
          height: 620,
        );
      }));
}

Future<void> deleteAlert(BuildContext context, StudentModel student) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content:
              const Text('If you want to delete click "Yes" or click "No"'),
          actions: [
            TextButton(
                onPressed: () {
                  deleteStudent(student);
                  Navigator.of(ctx).pop();
                },
                child: const Text('Yes')),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      });
}
