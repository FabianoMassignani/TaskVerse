// ignore: file_names
import 'package:get/get.dart';
import 'package:taskverse/controllers/authController.dart';
import 'package:taskverse/controllers/userController.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<UserController>(UserController(), permanent: true);
  }
}
