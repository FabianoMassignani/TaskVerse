import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:taskverse/services/database.service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Functions {
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
