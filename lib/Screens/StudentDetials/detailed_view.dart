import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetaildView extends StatelessWidget {
  const DetaildView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            CircleAvatar(radius: 60),
            SizedBox(
              height: 10,
            ),
            Text(
              "Vineeth",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            ShowAsRow(title: 'Age', value: '24'),
            ShowAsRow(title: 'Phone', value: '8182838485'),
            ShowAsRow(title: 'e-mail', value: 'vinee.kcl@gmail.com')
          ],
        ),
      ),
    );
  }
}

class ShowAsRow extends StatelessWidget {
  final String title;
  final String value;
  const ShowAsRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Text(
            ' : ',
            style: TextStyle(fontSize: 17),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
