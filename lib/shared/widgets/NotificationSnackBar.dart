import 'package:flutter/material.dart';

class NotificationSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
  }) {
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
