import 'package:flutter/material.dart';
import 'package:student_records/database/Models/studentModel.dart';
import 'package:student_records/database/functions/db_functions.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<StudentModel> studentList = [];
  CustomSearchDelegate({required this.studentList});
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
    if (query != null && studentList.contains(query.toLowerCase())) {}
    return Text('data');
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('');
    throw UnimplementedError();
  }
}
