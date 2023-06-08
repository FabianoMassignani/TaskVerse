import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskverse/controllers/authController.dart';
import 'package:taskverse/shared/widgets/Button_Primary.dart';
import 'package:taskverse/shared/widgets/widgets.dart';
import 'package:taskverse/utils/global.dart';
import 'package:taskverse/utils/validators.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final AuthController authController = Get.find();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(forgotPasswordTtitle),
        centerTitle: true,
        leading: Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: primaryIcon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                )),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 100.0),
        width: double.infinity,
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              forgotPassword2,
              style: paragraphWhiteBig,
              textAlign: TextAlign.center,
            ),
            Form(
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
                  espaco(30),
                  buttonPrimary(
                    () {
                      if (formkey.currentState!.validate()) {
                        authController.resetPassword(context, emailController);
                      }
                    },
                    forgotPassword3,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
