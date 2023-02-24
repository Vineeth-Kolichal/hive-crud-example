import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class InputFieldWidget extends StatelessWidget {
  TextEditingController inputController;
  String label;
  TextInputType type;
  bool isPassword = false;
  InputFieldWidget(
      {required this.inputController,
      required this.label,
      required this.type,
      bool? isPass}) {
    this.isPassword = isPass ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        obscureText: isPassword,
        keyboardType: type,
        controller: inputController,
        decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
