import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskverse/controllers/authController.dart';
import 'package:taskverse/shared/widgets/Button_Primary.dart';
import 'package:taskverse/utils/global.dart';
import 'package:taskverse/utils/validators.dart';

class SignUp extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignUp({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthController authController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool passwordVisible = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          espaco(40),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: TextFormField(
              style: formInputText,
              controller: nameController,
              decoration: nameDecoration,
              validator: Validator.nameValidator,
            ),
          ),
          espaco(15),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: TextFormField(
              style: formInputText,
              controller: emailController,
              decoration: emailInputDecoration,
              validator: Validator.emailValidator,
            ),
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
              validator: Validator.passwordValidator,
            ),
          ),
          espaco(40),
          buttonPrimary(
            () {
              if (formKey.currentState!.validate()) {
                authController.signUp(
                  emailController.text.trim(),
                  passwordController.text,
                  nameController.text,
                  context,
                );
              }
            },
            signUp,
          ),
          espaco(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                haveAccount,
                style: paragraphGray,
              ),
              GestureDetector(
                onTap: widget.onClickedSignIn,
                child: Text(
                  login,
                  style: paragraphPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
