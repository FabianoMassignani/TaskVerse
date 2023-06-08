import 'package:taskverse/controllers/dataController.dart';
import 'package:taskverse/controllers/authController.dart';
import 'package:taskverse/shared/widgets/Button_Secondary.dart';
import 'package:taskverse/shared/widgets/Card_Widget.dart';
import 'package:taskverse/shared/widgets/List_View_Widget.dart';
import 'package:taskverse/utils/routes.dart';
import 'package:taskverse/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskverse/shared/widgets/widgets.dart';
import '../shared/widgets/List_Dialog_Box.dart';
import 'settings/Settings_Scren.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthController authController = Get.find();
  final DataController data = Get.put(DataController());
  final String uid = Get.find<AuthController>().user!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Text("Taskverse", style: barTextStyle),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: IconButton(
                icon: primaryIcon(
                  Icons.settings,
                ),
                onPressed: () {
                  Navigator.of(context).push(Routes.route(
                      const SettingsScreen(), const Offset(0.0, 1.0)));
                },
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: [
              Column(children: [
                Row(
                  children: [
                    Expanded(
                        child: cardWidget(context, today, noToday,
                            data.todayTask, Icons.calendar_today)),
                    Expanded(
                        child: cardWidget(context, concludeds, noConcluded,
                            data.doneTask, Icons.done_rounded)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: cardWidget(context, scheduled, noScheduled,
                            data.scheduledTask, Icons.schedule)),
                    Expanded(
                      child: GestureDetector(
                          child: cardWidget(context, all, noAll, data.allTask,
                              Icons.all_inbox)),
                    ),
                  ],
                ),
              ]),
              espaco(15),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(list, style: barTextStyle)),
              espaco(15),
              ListViewWidget()
            ],
          ),
        ),
        floatingActionButton: buttonSecondary(() {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CustomDialogBox();
              });
        }, create, context));
  }
}
