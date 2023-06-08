import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskverse/controllers/authController.dart';
import 'package:taskverse/shared/widgets/Button_Primary.dart';
import 'package:taskverse/utils/global.dart';
import 'package:taskverse/utils/routes.dart';
import 'package:taskverse/utils/validators.dart';
import 'Password_Screen.dart';

class LogIn extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LogIn({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthController authController = Get.find();

  final emailController =
      TextEditingController(text: "fabiano-smi@hotmail.com");

  // TextEditingController passwordController = TextEditingController();
  final passwordController = TextEditingController(text: "fabiano");

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool passwordVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          espaco(40),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: TextFormField(
                style: formInputText,
                controller: emailController,
                decoration: emailInputDecoration,
                validator: Validator.emailValidator),
          ),
          espaco(15),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: TextFormField(
                obscureText: passwordVisible,
                style: formInputText,
                controller: passwordController,
                decoration: passwordDecoracao(passwordVisible, () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                }),
                validator: Validator.passwordValidator),
          ),
          espaco(15),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(Routes.route(const Password(), const Offset(1.0, 0.0)));
            },
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(forgotPassword, style: paragraphGray)),
            ),
          ),
          espaco(25),
          buttonPrimary(
            () {
              if (formkey.currentState!.validate()) {
                authController.signIn(emailController.text.trim(),
                    passwordController.text.trim(), context);
              }
            },
            login,
          ),
          espaco(25),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: widget.onClickedSignUp,
              child: Text(
                signUp,
                style: paragraphPrimary,
              ),
            )
          ]),
        ],
      ),
    );
  }
}
