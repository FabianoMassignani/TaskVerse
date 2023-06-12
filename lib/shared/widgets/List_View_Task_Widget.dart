import 'package:flutter/services.dart';
import 'package:taskverse/controllers/dataController.dart';
import 'package:taskverse/controllers/authController.dart';
import 'package:taskverse/services/notification.service.dart';
import 'package:taskverse/services/functions.service.dart';
import 'package:taskverse/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskverse/utils/routes.dart';
import 'package:taskverse/presentation/Task_Screen.dart';

class ListViewFilteredWidget extends StatefulWidget {
  final String title;
  final String infoText;
  final IconData icon;
  // ignore: prefer_typing_uninitialized_variables
  final data;

  const ListViewFilteredWidget({
    Key? key,
    required this.title,
    required this.data,
    required this.infoText,
    required this.icon,
  }) : super(key: key);

  @override
  State<ListViewFilteredWidget> createState() => _ListViewFilteredWidget();
}

class _ListViewFilteredWidget extends State<ListViewFilteredWidget> {
  final DataController data = Get.put(DataController());
  final String uid = Get.find<AuthController>().user!.uid;

  String getTitleText(String? title, item) {
    if (item.date != '' && item.time != '') {
      if (title != null && title.length > 15) {
        return '${title.substring(0, 15)}...';
      }
    }
    return title ?? '';
  }

  bool isDateTimeVisible(item) {
    return item.date != '' && item.time != '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.title),
      ),
      extendBodyBehindAppBar: true,
      body: Obx(() => Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: widget.data.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.list, color: Colors.white, size: 90.0),
                        espaco(5),
                        Text(nolist, style: buttonTextWhite),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: widget.data.length,
                    separatorBuilder: (context, index) => espaco(10),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                      child: Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          HapticFeedback.heavyImpact();
                          var arrayIndex = 0;
                          var taskIndex = 0;

                          for (var array in data.lists) {
                            if (array.title == widget.data[index].arrayTitle) {
                              arrayIndex = data.lists.indexOf(array);
                            }
                          }

                          for (var task in data.lists[arrayIndex].task!) {
                            if (widget.data[index].id == task.id) {
                              taskIndex =
                                  data.lists[arrayIndex].task!.indexOf(task);
                            }
                          }

                          NotificationService()
                              .flutterLocalNotificationsPlugin
                              .cancel(
                                  data.lists[arrayIndex].task![taskIndex].id!);

                          Functions.deleteTodo(
                              data, uid, arrayIndex, taskIndex);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              showCloseIcon: true,
                              closeIconColor: Colors.white,
                              backgroundColor: Colors.indigo,
                              content: Text(
                                'Remoção bem sucedida',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                        confirmDismiss: (direction) async {
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Confirma remover?'),
                                content: Text(
                                  'Remover ${widget.data[index].title}?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Remover',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            color: colorBoxPrimary,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        getTitleText(widget.data[index].title,
                                            widget.data[index]),
                                        style: todoTitleStyle(
                                            widget.data[index].done)),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      isDateTimeVisible(widget.data[index]),
                                  child: Obx(
                                    () => Text(
                                      Functions.getFormattedDateTime(
                                          widget.data[index]),
                                      style: filteredDateStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        var arrayIndex = 0;
                        var taskIndex = 0;
                        for (var lists in data.lists) {
                          if (lists.title == widget.data[index].arrayTitle) {
                            arrayIndex = data.lists.indexOf(lists);
                          }
                        }
                        for (var task in data.lists[arrayIndex].task!) {
                          if (widget.data[index].id == task.id) {
                            taskIndex =
                                data.lists[arrayIndex].task!.indexOf(task);
                          }
                        }
                        Navigator.of(context).push(Routes.route(
                          TodoScreen(
                            arrayIndex: arrayIndex,
                            taskIndex: taskIndex,
                          ),
                          const Offset(0.0, 1.0),
                        ));
                      },
                    ),
                  ),
          )),
    );
  }
}
