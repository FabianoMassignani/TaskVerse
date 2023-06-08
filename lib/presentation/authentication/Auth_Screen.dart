// ignore: file_names
import 'package:flutter/material.dart';
import 'package:taskverse/utils/global.dart';
import 'package:taskverse/presentation/authentication/login_widget.dart';
import 'package:taskverse/presentation/authentication/signup_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggle() => setState(() {
        isLogin = !isLogin;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Task", style: heading(whiteColor)),
                Text("verse", style: heading(redColor)),
              ],
            ),
            if (isLogin)
              LogIn(onClickedSignUp: toggle)
            else
              SignUp(onClickedSignIn: toggle),
          ],
        ),
      ),
    );
  }
}
