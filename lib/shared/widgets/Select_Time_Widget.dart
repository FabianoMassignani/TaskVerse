import 'package:flutter/material.dart';

Future<TimeOfDay?> selectTime(
    BuildContext context, TimeOfDay? selectedTime) async {
  return await showTimePicker(
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark(),
        child: child!,
      );
    },
    context: context,
    initialTime: selectedTime ?? TimeOfDay.now(),
    initialEntryMode: TimePickerEntryMode.input,
  );
}
