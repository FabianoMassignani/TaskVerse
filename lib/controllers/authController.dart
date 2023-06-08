import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskverse/controllers/dataController.dart';
import 'package:taskverse/controllers/userController.dart';
import 'package:taskverse/main.dart';
import 'package:taskverse/models/User.dart';
import 'package:taskverse/services/notification.service.dart';
import 'package:taskverse/services/database.service.dart';
import 'package:taskverse/shared/widgets/NotificationSnackBar.dart';
import '../utils/global.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => _firebaseUser.value;

  @override
  void onInit() {
    super.onInit();

    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  Future signIn(String email, String password, context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => const Center(
                child: CircularProgressIndicator(
              color: basicColor,
            ))));

    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      Get.find<UserController>().user =
          await Database().getUser(authResult.user!.uid);

      navigatorKey.currentState!.pop(context);
    } on FirebaseAuthException {
      NotificationSnackBar.show(
        context: context,
        message: 'A senha é inválida ou o usuário não possui senha',
        backgroundColor: secondaryColor,
      );

      navigatorKey.currentState!.pop(context);
    }
  }

  Future signUp(email, password, name, context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => const Center(
                child: CircularProgressIndicator(
              color: basicColor,
            ))));

    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel user =
          UserModel(id: authResult.user!.uid, name: name, email: email);

      if (await Database().createNewUser(user)) {
        Get.find<UserController>().user = user;
      }

      navigatorKey.currentState!.pop(context);
    } on FirebaseAuthException catch (e) {
      NotificationSnackBar.show(
        context: context,
        message: e.message!,
        backgroundColor: secondaryColor,
      );

      navigatorKey.currentState!.pop(context);
    }
  }

  Future resetPassword(context, emailController) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => const Center(
                child: CircularProgressIndicator(
              color: basicColor,
            ))));

    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);

      NotificationSnackBar.show(
        context: context,
        message: 'Email de reset de senha enviado.',
        backgroundColor: secondaryColor,
      );

      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      NotificationSnackBar.show(
        context: context,
        message: e.message!,
        backgroundColor: secondaryColor,
      );

      navigatorKey.currentState!.pop(context);
    }
  }

  Future signOut(context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => const Center(
                child: CircularProgressIndicator(
              color: basicColor,
            ))));

    try {
      NotificationService().flutterLocalNotificationsPlugin.cancelAll();

      await _auth.signOut();

      Get.find<UserController>().clear();
      Get.delete<DataController>();

      Navigator.pop(context, 'Ok');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      NotificationSnackBar.show(
        context: context,
        message: e.message!,
        backgroundColor: secondaryColor,
      );

      navigatorKey.currentState!.pop(context);
    }
  }
}
