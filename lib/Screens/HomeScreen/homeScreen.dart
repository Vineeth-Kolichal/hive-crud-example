import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:student_records/Database/Models/studentModel.dart';
import 'package:student_records/Database/functions/db_functions.dart';
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
  @override
  Widget build(BuildContext context) {
    getAllData();
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder(
                valueListenable: studentNotifier,
                builder: (BuildContext ctx, List<StudentModel> stude,
                    Widget? child) {
                  return ListView.separated(
                      itemBuilder: (ctx, index) {
                        StudentModel stu = stude[index];
                        File? _image;
                        if (stu.imgPath != null) {
                          _image = File(stu.imgPath!);
                        }
                        return Card(
                          color: Color.fromARGB(255, 241, 239, 239),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => DetaildView(
                                      name: stu.name,
                                      age: stu.age,
                                      phone: stu.phone,
                                      email: stu.mail,
                                      image: _image)));
                            },
                            title: Text(stu.name),
                            leading: CircleAvatar(
                              backgroundColor: Colors.black54,
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(20),
                                  child: (_image != null)
                                      ? Image.file(
                                          _image,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset('assets/images/user.png'),
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
                                      updateStudent(stude[index], context);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deleteStudent(stude[index]);
                                    },
                                    icon: Icon(
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
                        return SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: stude.length);
                })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InputPage(),
          ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
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

// Future<dynamic> bottomSheet(BuildContext context) async {
//   return await showModalBottomSheet(
//       context: context,
//       builder: ((BuildContext ctx) {
//         return SizedBox(
//           child: InputBottonSheet(),
//           height: 620,
//         );
//       }));
// }
