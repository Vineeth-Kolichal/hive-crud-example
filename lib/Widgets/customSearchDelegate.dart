import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/Screens/HomeScreen/homeScreen.dart';
import 'package:student_records/Screens/StudentDetials/detailed_view.dart';
import 'package:student_records/database/Models/studentModel.dart';
import 'package:student_records/database/functions/db_functions.dart';

List<StudentModel> studentList =
    Hive.box<StudentModel>('student_db').values.toList();
List<StudentModel> studentDisplay = List<StudentModel>.from(studentList);

class CustomSearchDelegate extends SearchDelegate {
  //List<StudentModel> studentList = [];
  CustomSearchDelegate();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = " ";
          },
          icon: Icon(Icons.clear))
    ];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back));
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // if (query != null && studentList.contains(query.toLowerCase())) {}
    return SearchResult();
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('');
    throw UnimplementedError();
  }
}

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (ctx, index) {
          StudentModel stu = studentDisplay[index];
          File? _image;
          if (stu.imgPath != 'no-img') {
            _image = File(stu.imgPath!);
          }
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                        deleteAlert(context, studentDisplay[index]);
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
        itemCount: studentDisplay.length);
  }
}
