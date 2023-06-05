import 'package:flutter/material.dart';

Future<DateTime?> selectDate(BuildContext context, DateTime? selectedDate) =>
    showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
