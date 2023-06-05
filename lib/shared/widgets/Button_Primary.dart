// ignore: file_names
import 'package:flutter/material.dart';

Container buttonPrimary(
  VoidCallback function,
  String title,
) {
  return Container(
    constraints: const BoxConstraints(maxWidth: 260),
    width: 200,
    height: 50,
    child: ElevatedButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle?>(const TextStyle(
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
        )),
        shape: MaterialStateProperty.all<OutlinedBorder?>(
          RoundedRectangleBorder(
              side: const BorderSide(width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(9)),
        ),
      ),
      onPressed: function,
      child: Text(title),
    ),
  );
}
