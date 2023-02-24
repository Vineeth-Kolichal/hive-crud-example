import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:student_records/Screens/HomeScreen/homeScreen.dart';
import 'package:student_records/Widgets/inputFieldWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mailIDController = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/user.png'),
            radius: 40,
            backgroundColor: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Login',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
          InputFieldWidget(
              inputController: _mailIDController,
              label: 'e-mail',
              type: TextInputType.emailAddress),
          SizedBox(
            height: 15,
          ),
          InputFieldWidget(
              isPass: true,
              inputController: _password,
              label: 'Password',
              type: TextInputType.text),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.black)))),
                  onPressed: () {
                    print(_mailIDController.text);
                    print(_password.text);
                    if (_mailIDController.text == 'vinee.kcl@gmail.com' &&
                        _password.text == 'vineeth') {
                      print('is it working');
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: ((ctx) => HomeScreen()),
                        ),
                      );
                    }
                  },
                  child: Text('Login', style: TextStyle(fontSize: 15)),
                ),
              ),
            ],
          ),
        ]),
      ),
    ));
  }
}

