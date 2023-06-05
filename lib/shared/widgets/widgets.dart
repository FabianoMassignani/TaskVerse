import 'package:flutter/material.dart';
import 'package:taskverse/utils/global.dart';
import 'package:taskverse/utils/validators.dart';

TextFormField primaryTextField(BuildContext context, controller, maxLines,
    maxLength, textInputAction, hintText, style) {
  return TextFormField(
      validator: Validator.titleValidator,
      controller: controller,
      autofocus: true,
      autocorrect: false,
      cursorColor: Colors.grey,
      maxLines: maxLines,
      maxLength: maxLength,
      textInputAction: textInputAction,
      decoration: InputDecoration(
          counterStyle: counterTextStyle,
          hintText: hintText,
          hintStyle: hintTextStyle,
          border: InputBorder.none),
      style: style);
}

Icon primaryIcon(
  icon,
) {
  return Icon(
    icon,
    color: const Color(0xFFEAEAEA),
  );
}
