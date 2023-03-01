import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/Screens/HomeScreen/homeScreen.dart';
import 'package:student_records/database/Models/studentModel.dart';
import 'package:student_records/database/functions/db_functions.dart';

import '../StudentDetials/detailed_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<StudentModel> studentList =
      Hive.box<StudentModel>('student_db').values.toList();
  late List<StudentModel> studentSearch = List<StudentModel>.from(studentList);

  TextEditingController searchCotntroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(241, 243, 241, 241),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) => _searchStudent(value),
                controller: searchCotntroller,
                decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        clearSearch();
                      },
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(40))),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (ctx, index) {
                      StudentModel stu = studentSearch[index];
                      File? _image;
                      if (stu.imgPath != 'no-img') {
                        _image = File(stu.imgPath!);
                      }
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
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
                            backgroundColor: Colors.black12,
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(20),
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
                                    bottomSheet(context, stu);
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteAlert(context, studentSearch[index]);
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
                    itemCount: studentSearch.length),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _searchStudent(String value) {
    setState(() {
      studentSearch = studentList
          .where((element) =>
              element.name.toLowerCase().contains(value.trim().toLowerCase()))
          .toList();
    });
    print(value);
    print(studentSearch.toList());
  }

  void clearSearch() {
    searchCotntroller.clear();
  }
}
