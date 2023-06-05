// ignore_for_file: file_names, empty_statements
import 'package:taskverse/controllers/dataController.dart';
import 'package:taskverse/controllers/authController.dart';
import 'package:taskverse/presentation/Task_Screen.dart';
import 'package:taskverse/services/functions.service.dart';
import 'package:taskverse/shared/widgets/widgets.dart';
import 'package:taskverse/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskverse/utils/routes.dart';
import 'package:flutter/services.dart';
import 'package:taskverse/services/notification.service.dart';

class HomeScreen extends StatefulWidget {
  final int? index;
  const HomeScreen({Key? key, this.index}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataController data = Get.put(DataController());
  final String uid = Get.find<AuthController>().user!.uid;

  bool isDateTimeVisible(item) {
    return item.date != '' && item.time != '';
  }

  String getFormattedDateTime(item) {
    return '${item.date}, ${item.time}';
  }

  String getTitleText(item) {
    String? title = item.title;

    if (item.date != '' && item.time != '') {
      if (title != null && title.length > 15) {
        return '${title.substring(0, 15)}...';
      }
    }
    return title ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            data.lists[widget.index!].title!,
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Obx(() => Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: (data.lists[widget.index!].task!.isEmpty)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text(notask, style: infoTextStyle)),
                      ],
                    )
                  : GetX<DataController>(
                      init: Get.put<DataController>(DataController()),
                      builder: (DataController data) {
                        return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => GestureDetector(
                                  child: Dismissible(
                                    key: UniqueKey(),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (_) async {
                                      HapticFeedback.heavyImpact();

                                      NotificationService()
                                          .flutterLocalNotificationsPlugin
                                          .cancel(data.lists[widget.index!]
                                              .task![index].id!);

                                      Functions.deleteTodo(
                                          data, uid, widget.index, index);
                                    },
                                    confirmDismiss: (direction) async {
                                      return showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Confirma remover?'),
                                            content: Text(
                                              'Remover ${data.lists[widget.index!].task![index].title}?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: const Text('Cancelar'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(true);
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: colorBoxPrimary,
                                        borderRadius:
                                            BorderRadius.circular(14.0),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 25.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Text(
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    getTitleText(data
                                                        .lists[widget.index!]
                                                        .task![index]),
                                                    style: todoTitleStyle(data
                                                        .lists[widget.index!]
                                                        .task![index]
                                                        .done)),
                                              ),
                                            ),
                                            Visibility(
                                              visible: isDateTimeVisible(data
                                                  .lists[widget.index!]
                                                  .task![index]),
                                              child: Obx(
                                                () => Text(
                                                  getFormattedDateTime(data
                                                      .lists[widget.index!]
                                                      .task![index]),
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
                                    Navigator.of(context).push(Routes.route(
                                        TodoScreen(
                                          arrayIndex: widget.index,
                                          taskIndex: index,
                                        ),
                                        const Offset(0.0, 1.0)));
                                  },
                                ),
                            separatorBuilder: (context, index) =>
                                espaco(10), // Espaço entre os itens
                            shrinkWrap: true,
                            itemCount: data.lists[widget.index!].task!.length);
                      }),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(Routes.route(
                TodoScreen(arrayIndex: widget.index), const Offset(0.0, 1.0)));
          },
          child: primaryIcon(Icons.add),
        ));
  }
}
