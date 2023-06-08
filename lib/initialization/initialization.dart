import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskverse/presentation/authentication/Auth_Screen.dart';
import 'package:taskverse/presentation/Main_Screen.dart';
import 'package:taskverse/controllers/Bindings.dart';
import 'package:get/get.dart';
import 'package:taskverse/main.dart';
import 'package:taskverse/utils/global.dart';

class TaskVerse extends StatelessWidget {
  const TaskVerse({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Taskverse',
      initialBinding: Binding(),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(color: backgroundColor)),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: basicColor,
              ));
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(somethingWrong, style: heading(Colors.white)));
            } else if (snapshot.hasData) {
              return const MainScreen();
            } else {
              return const AuthScreen();
            }
          }),
    );
  }
}
