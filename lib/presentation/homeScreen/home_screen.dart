import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:student_records/domain/studentModel.dart';
import 'package:student_records/infrastructure/db_functions.dart';
import 'package:student_records/presentation/pages/search_page.dart';
import 'package:student_records/presentation/StudentDetials/detailed_view.dart';
import 'package:student_records/presentation/homeScreen/input_page.dart';
import 'package:student_records/Widgets/input_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getAllData();
    return Scaffold(
      backgroundColor: const Color.fromARGB(241, 243, 241, 241),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: studentNotifier,
                      builder: (context, student, child) {
                        if (student.isEmpty) {
                          return const Center(
                            child: Text(
                                'No Student details, click button to add student details'),
                          );
                        } else {
                          return ListView.separated(
                              itemBuilder: (ctx, index) {
                                StudentModel stu = student[index];
                                File? image;
                                if (stu.imgPath != 'no-img') {
                                  image = File(stu.imgPath!);
                                }
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: ListTile(
                                    onTap: () {
                                      Get.to(
                                        DetaildView(
                                            name: stu.name,
                                            age: stu.age,
                                            phone: stu.phone,
                                            email: stu.mail,
                                            image: image),
                                      );
                                    },
                                    title: Text(stu.name),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.black12,
                                      child: ClipOval(
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(20),
                                          child: (image != null)
                                              ? Image.file(
                                                  image,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                        }
                      }),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(InputPage());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              Get.to(const SearchPage(), transition: Transition.cupertino);
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
        title: const Text('Student List'),
      ),
    );
  }
}

Future<dynamic> bottomSheet(BuildContext context, StudentModel student) async {
  return await showModalBottomSheet(
      context: context,
      builder: ((BuildContext ctx) {
        return SizedBox(
          height: 660,
          child: InputBottonSheet(
            student: student,
          ),
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
                  Get.back();
                },
                child: const Text('Yes')),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('No'),
            ),
          ],
        );
      });
}
