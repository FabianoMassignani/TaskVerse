import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskverse/models/Task.dart';
import 'package:taskverse/services/notification.service.dart';
import 'package:taskverse/services/database.service.dart';
import 'package:taskverse/shared/widgets/NotificationSnackBar.dart';
import 'package:taskverse/utils/global.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Functions {
  static void onCancelButtonPressed() {
    Get.back();
  }

  static String getFormattedDateTime(item) {
    DateTime dateTime =
        DateFormat('MM/dd/yyyy hh:mm a').parse('${item.date} ${item.time}');
    DateTime today = DateTime.now();
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

    if (dateTime.year == today.year &&
        dateTime.month == today.month &&
        dateTime.day == today.day) {
      return 'Hoje ${item.time}';
    } else if (dateTime.year == tomorrow.year &&
        dateTime.month == tomorrow.month &&
        dateTime.day == tomorrow.day) {
      return 'Amanhã ${item.time}';
    } else {
      String formattedDate = DateFormat('MM/dd').format(dateTime);
      String formattedTime = DateFormat('hh:mm').format(dateTime);
      String formattedYear = DateFormat('yyyy').format(dateTime);

      if (dateTime.year != today.year) {
        return '$formattedDate/$formattedYear $formattedTime';
      } else {
        return '$formattedDate $formattedTime';
      }
    }
  }

  static Future<void> changeDone({
    required String uid,
    required bool done,
    required int? id,
    required data,
    required int? taskIndex,
    required int arrayIndex,
  }) async {
    var lista = data.lists[arrayIndex];
    var editing = data.lists[arrayIndex].task![taskIndex];
    editing.done = done;
    lista.task![taskIndex] = editing;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("lists")
        .doc(lista.id)
        .set({
      "title": lista.title,
      "dateCreated": lista.dateCreated,
      "task": lista.task!.map((task) => task.toJson()).toList(),
    });

    Database().updateTarefa(
      uid,
      editing.id,
      lista.title!,
      title,
      editing.details,
      Timestamp.now(),
      editing.date,
      editing.time,
      done,
      (editing.date != '' && editing.time != '') ? true : false,
      lista.task![taskIndex].id!,
    );
  }

  static Future<void> onSaveButtonPressed({
    required String uid,
    required GlobalKey<FormState> formKey,
    required String title,
    required String detail,
    required String dateController,
    required String timeController,
    required bool done,
    required int? taskIndex,
    required int arrayIndex,
    required data,
    required BuildContext context,
  }) async {
    var lista = data.lists[arrayIndex];

    if (taskIndex == null && formKey.currentState!.validate()) {
      var finalId = UniqueKey().hashCode;

      lista.task!.add(Task(
        title: title,
        details: detail,
        id: finalId,
        date: dateController,
        time: timeController,
        dateAndTimeEnabled:
            (dateController != '' && timeController != '') ? true : false,
        done: false,
        dateCreated: Timestamp.now(),
      ));

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("lists")
          .doc(lista.id)
          .set({
        "title": lista.title,
        "dateCreated": lista.dateCreated,
        "task": lista.task!.map((task) => task.toJson()).toList(),
      });

      Database().addAllTarefa(
        uid,
        finalId,
        lista.title!,
        title,
        detail,
        Timestamp.now(),
        dateController,
        timeController,
        false,
        (dateController != '' && timeController != '') ? true : false,
        finalId,
      );

      Get.back();

      HapticFeedback.heavyImpact();

      if (dateController.isNotEmpty && timeController.isNotEmpty) {
        bool isScheduled = await NotificationService().scheduleNotification(
          finalId,
          'Reminder',
          title,
          Functions.parseDateTime(
            dateController,
            timeController,
          ),
        );

        if (!isScheduled) {
          // ignore: use_build_context_synchronously
          NotificationSnackBar.show(
            context: context,
            message: 'Não foi possível agendar uma notificação.',
            backgroundColor: secondaryColor,
          );
        }
      }
    }

    if (taskIndex != null && formKey.currentState!.validate()) {
      var editing = data.lists[arrayIndex].task![taskIndex];

      editing.title = title;
      editing.details = detail;
      editing.date = dateController;
      editing.time = timeController;
      editing.done = done;

      editing.dateAndTimeEnabled =
          (dateController != '' && timeController != '') ? true : false;

      lista.task![taskIndex] = editing;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("lists")
          .doc(lista.id)
          .set({
        "title": lista.title,
        "dateCreated": lista.dateCreated,
        "task": lista.task!.map((task) => task.toJson()).toList(),
      });

      Database().updateTarefa(
        uid,
        lista.task![taskIndex].id!,
        lista.title!,
        title,
        detail,
        Timestamp.now(),
        dateController,
        timeController,
        done,
        (dateController != '' && timeController != '') ? true : false,
        lista.task![taskIndex].id!,
      );

      Get.back();

      HapticFeedback.heavyImpact();

      if (dateController.isNotEmpty && timeController.isNotEmpty) {
        var id = lista.task![taskIndex].id!;
        NotificationService().flutterLocalNotificationsPlugin.cancel(id);

        var dataHora = Functions.parseDateTime(dateController, timeController);

        bool isScheduled = await NotificationService().scheduleNotification(
          id,
          'Reminder',
          title,
          dataHora,
        );

        if (!isScheduled) {
          // ignore: use_build_context_synchronously
          NotificationSnackBar.show(
            context: context,
            message: 'Não foi possível agendar uma notificação.',
            backgroundColor: secondaryColor,
          );
        }
      } else {
        NotificationService()
            .flutterLocalNotificationsPlugin
            .cancel(lista.task![taskIndex].id!);
      }
    }
  }

  static tz.TZDateTime parseDateTime(String date, String time) {
    tz.initializeTimeZones();

    String value = '$date $time';
    if (value.isNotEmpty) {
      DateTime? dateTime;
      try {
        bool isUtc = false;
        dateTime =
            DateFormat("MM/dd/yyyy hh:mm a").parse(value, isUtc).toLocal();
      } catch (e) {
        throw Exception("Failed to parse date time");
      }

      tz.TZDateTime parsedDateTime =
          tz.TZDateTime.from(dateTime, tz.getLocation('America/Sao_Paulo'));

      return parsedDateTime;
    } else {
      throw Exception("Failed to parse date time");
    }
  }

  static deleteTodo(arrayController, uid, arrayIndex, todoIndex) async {
    Database().deleteAllTarefa(
        uid, arrayController.lists[arrayIndex].task![todoIndex].id!);
    arrayController.lists[arrayIndex].task!.removeAt(todoIndex);
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("lists")
          .doc(arrayController.lists[arrayIndex].id)
          .set({
        "title": arrayController.lists[arrayIndex].title,
        "dateCreated": arrayController.lists[arrayIndex].dateCreated,
        "task": arrayController.lists[arrayIndex].task!
            .map((todo) => todo.toJson())
            .toList()
      });

      arrayController.update();
    } catch (e) {}
  }

  static deleteLista(uid, arrayController, index) {
    Database().deleteLista(uid, arrayController.lists[index].id ?? '');

    for (var i = 0; i < arrayController.lists[index].task!.length; i++) {
      Database()
          .deleteAllTarefa(uid, arrayController.lists[index].task![i].id!);
    }
  }
}
