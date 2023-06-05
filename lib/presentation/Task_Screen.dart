import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskverse/controllers/authController.dart';
import 'package:taskverse/controllers/dataController.dart';
import 'package:taskverse/models/Task.dart';
import 'package:taskverse/services/database.service.dart';
import 'package:taskverse/services/functions.service.dart';
import 'package:taskverse/shared/widgets/Select_Date_Widget%20copy.dart';
import 'package:taskverse/shared/widgets/Select_Time_Widget.dart';
import 'package:taskverse/services/notification.service.dart';
import 'package:taskverse/utils/global.dart';
import 'package:taskverse/utils/validators.dart';

final formKey = GlobalKey<FormState>();

class TodoScreen extends StatefulWidget {
  final int? taskIndex;
  final int? arrayIndex;

  const TodoScreen({Key? key, this.taskIndex, this.arrayIndex})
      : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final DataController data = Get.find();
  final AuthController authController = Get.find();
  final String uid = Get.find<AuthController>().user!.uid;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController titleEditingController;
  late TextEditingController detailEditingController;

  late String _hour, _minute, _time;
  late String dateTime;
  late bool done;

  @override
  void initState() {
    super.initState();
    String title = '';
    String detail = '';
    String date = '';
    String? time = '';

    if (widget.taskIndex != null) {
      title =
          data.lists[widget.arrayIndex!].task![widget.taskIndex!].title ?? '';
      detail =
          data.lists[widget.arrayIndex!].task![widget.taskIndex!].details ?? '';
      date = data.lists[widget.arrayIndex!].task![widget.taskIndex!].date!;
      time = data.lists[widget.arrayIndex!].task![widget.taskIndex!].time;
    }

    _dateController = TextEditingController(text: date);
    _timeController = TextEditingController(text: time);
    titleEditingController = TextEditingController(text: title);
    detailEditingController = TextEditingController(text: detail);
    done = (widget.taskIndex == null)
        ? false
        : data.lists[widget.arrayIndex!].task![widget.taskIndex!].done!;
  }

  @override
  void dispose() {
    super.dispose();
    titleEditingController.dispose();
    detailEditingController.dispose();
    _timeController.dispose();
    _dateController.dispose();
  }

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(
      hour: (TimeOfDay.now().minute > 55)
          ? TimeOfDay.now().hour + 1
          : TimeOfDay.now().hour,
      minute: (TimeOfDay.now().minute > 55) ? 0 : TimeOfDay.now().minute + 5);

  Future<void> _pickDateTime() async {
    DateTime? date = await selectDate(context, selectedDate);

    if (date == null) return;

    selectedDate = date;

    _dateController.text = DateFormat("MM/dd/yyyy").format(selectedDate);

    TimeOfDay? time = await selectTime(context, selectedTime);

    if (time == null) {
      time = TimeOfDay(
        hour: DateTime.now().hour,
        minute: DateTime.now().minute + 5,
      );

      _timeController.text = formatDate(
        DateTime(
          DateTime.now().year,
          DateTime.now().day,
          DateTime.now().month,
          time.hour,
          time.minute,
        ),
        [hh, ':', nn, ' ', am],
      ).toString();
    }

    selectedTime = time;
    _hour = selectedTime.hour.toString();
    _minute = selectedTime.minute.toString();
    _time = '$_hour : $_minute';
    _timeController.text = _time;

    _timeController.text = formatDate(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selectedTime.hour,
        selectedTime.minute,
      ),
      [hh, ':', nn, ' ', am],
    ).toString();
  }

  @override
  Widget build(BuildContext context) {
    bool visible =
        (_dateController.text.isEmpty && _timeController.text.isEmpty)
            ? false
            : true;

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              (widget.taskIndex == null) ? newTask : updateTask,
              style: menuTextStyle,
            ),
            leadingWidth: 100.0,
            leading: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 21.0),
                child: TextButton(
                  style: const ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    cancel,
                    style: menuTextStyle,
                  ),
                ),
              ),
            ),
            centerTitle: true,
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 21.0),
                  child: TextButton(
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: () async {
                      var lista = data.lists[widget.arrayIndex!];

                      if (widget.taskIndex == null &&
                          formKey.currentState!.validate()) {
                        var finalId = UniqueKey().hashCode;

                        lista.task!.add(Task(
                          title: titleEditingController.text,
                          details: detailEditingController.text,
                          id: finalId,
                          date: _dateController.text,
                          time: _timeController.text,
                          dateAndTimeEnabled: (_dateController.text != '' &&
                                  _timeController.text != '')
                              ? true
                              : false,
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
                          "task":
                              lista.task!.map((task) => task.toJson()).toList()
                        });

                        Database().addAllTarefa(
                          uid,
                          finalId,
                          lista.title!,
                          titleEditingController.text,
                          detailEditingController.text,
                          Timestamp.now(),
                          _dateController.text,
                          _timeController.text,
                          false,
                          (_dateController.text != '' &&
                                  _timeController.text != '')
                              ? true
                              : false,
                          finalId,
                        );

                        Get.back();

                        HapticFeedback.heavyImpact();

                        if (_dateController.text.isNotEmpty &&
                            _timeController.text.isNotEmpty) {
                          NotificationService().showNotification(
                              finalId,
                              'Reminder',
                              titleEditingController.text,
                              Functions.parseDateTime(
                                  _dateController.text, _timeController.text));
                        }
                      }

                      if (widget.taskIndex != null &&
                          formKey.currentState!.validate()) {
                        var editing = data
                            .lists[widget.arrayIndex!].task![widget.taskIndex!];

                        editing.title = titleEditingController.text;
                        editing.details = detailEditingController.text;
                        editing.date = _dateController.text;
                        editing.time = _timeController.text;
                        editing.done = done;

                        editing.dateAndTimeEnabled =
                            (_dateController.text != '' &&
                                    _timeController.text != '')
                                ? true
                                : false;

                        lista.task![widget.taskIndex!] = editing;

                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(uid)
                            .collection("lists")
                            .doc(lista.id)
                            .set({
                          "title": lista.title,
                          "dateCreated": lista.dateCreated,
                          "task":
                              lista.task!.map((task) => task.toJson()).toList()
                        });

                        Database().updateTarefa(
                          uid,
                          lista.task![widget.taskIndex!].id!,
                          lista.title!,
                          titleEditingController.text,
                          detailEditingController.text,
                          Timestamp.now(),
                          _dateController.text,
                          _timeController.text,
                          done,
                          (_dateController.text != '' &&
                                  _timeController.text != '')
                              ? true
                              : false,
                          lista.task![widget.taskIndex!].id!,
                        );

                        Get.back();

                        HapticFeedback.heavyImpact();

                        if (_dateController.text.isNotEmpty &&
                            _timeController.text.isNotEmpty) {
                          var id = lista.task![widget.taskIndex!].id!;
                          NotificationService()
                              .flutterLocalNotificationsPlugin
                              .cancel(id);

                          var dataHora = Functions.parseDateTime(
                              _dateController.text, _timeController.text);

                          NotificationService().showNotification(id, 'Reminder',
                              titleEditingController.text, dataHora);
                        } else {
                          NotificationService()
                              .flutterLocalNotificationsPlugin
                              .cancel(lista.task![widget.taskIndex!].id!);
                        }
                      }
                    },
                    child: Text(
                      (widget.taskIndex == null) ? add : update,
                      style: menuTextStyle,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: Container(
              width: double.infinity,
              padding: (MediaQuery.of(context).size.width < 768)
                  ? const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0)
                  : const EdgeInsets.symmetric(
                      horizontal: 35.0, vertical: 15.0),
              child: Column(
                children: [
                  Visibility(
                    visible: (widget.taskIndex != null) ? true : false,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: tertiaryColor,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            concluded,
                            style: taskScreenStyle,
                          ),
                          Transform.scale(
                            scale: 1.3,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: const Color.fromARGB(
                                  255,
                                  187,
                                  187,
                                  187,
                                ),
                              ),
                              child: Checkbox(
                                shape: const CircleBorder(),
                                checkColor: Colors.white,
                                activeColor: basicColor,
                                value: done,
                                side: Theme.of(context).checkboxTheme.side,
                                onChanged: (value) {
                                  setState(() {
                                    done = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  espaco(10),
                  Container(
                    decoration: BoxDecoration(
                      color: tertiaryColor,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 15.0,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            validator: Validator.titleValidator,
                            controller: titleEditingController,
                            autofocus: true,
                            autocorrect: false,
                            cursorColor: Colors.grey,
                            maxLines: 1,
                            maxLength: 25,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              counterStyle: counterTextStyle,
                              hintStyle: hintTextStyle,
                              hintText: title,
                              border: InputBorder.none,
                            ),
                            style: taskScreenStyle,
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 255, 255, 255),
                            thickness: 1.0,
                          ),
                          TextField(
                            controller: detailEditingController,
                            maxLines: null,
                            autocorrect: false,
                            cursorColor: Colors.grey,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              counterStyle: counterTextStyle,
                              hintStyle: hintTextStyle,
                              hintText: description,
                              border: InputBorder.none,
                            ),
                            style: GoogleFonts.notoSans(
                              color: const Color(0xFFA8A8A8),
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  espaco(10),
                  GestureDetector(
                    onTap: () async {
                      await _pickDateTime();

                      setState(() {
                        visible = true;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 15.0,
                      ),
                      decoration: BoxDecoration(
                        color: tertiaryColor,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  enabled: false,
                                  controller: _dateController,
                                  onChanged: (String val) {},
                                  decoration: InputDecoration(
                                    hintText: "Dia",
                                    hintStyle: hintTextStyle,
                                    border: InputBorder.none,
                                  ),
                                  style: taskScreenStyle,
                                ),
                              ),
                              visible
                                  ? IconButton(
                                      onPressed: () {
                                        _dateController.clear();
                                        _timeController.clear();
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 255, 255, 255),
                            thickness: 1.0,
                          ),
                          TextField(
                            enabled: false,
                            controller: _timeController,
                            decoration: InputDecoration(
                              hintText: time,
                              hintStyle: hintTextStyle,
                              border: InputBorder.none,
                            ),
                            style: taskScreenStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
