import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

// ignore: must_be_immutable
class DetaildView extends StatelessWidget {
  final String name;
  final String age;
  final String phone;
  final String email;
  File? image;

  DetaildView(
      {super.key,
      required this.name,
      required this.age,
      required this.phone,
      required this.email,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back)),
              ],
            )),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              CircleAvatar(
                radius: 60,
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(60),
                    child: (image != null)
                        ? Image.file(
                            image!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset('assets/images/user.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              ShowAsRow(title: 'Age', value: age),
              ShowAsRow(title: 'Phone', value: phone),
              ShowAsRow(title: 'e-mail', value: email)
            ],
          ),
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
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const Text(
            ' : ',
            style: TextStyle(fontSize: 17),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
