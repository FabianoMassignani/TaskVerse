import 'package:flutter/material.dart';
import 'package:taskverse/utils/global.dart';

Padding buttonSecondary(VoidCallback onTap, String title, context) {
  return Padding(
    padding: (MediaQuery.of(context).size.width < 768)
        ? const EdgeInsets.only(right: 0.0)
        : const EdgeInsets.only(right: 15.0),
    child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: tertiaryColor, borderRadius: BorderRadius.circular(14.0)),
          width: 130.0,
          height: 45.0,
          child: Center(
            child: Text(title,
                style: const TextStyle(color: basicColor, fontSize: 23.0)),
          ),
        )),
  );
}
