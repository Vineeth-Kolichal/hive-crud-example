import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[IconButton(onPressed: () {}, icon: Icon(Icons.clear))];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back));
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('data');
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('');
    throw UnimplementedError();
  }
}
