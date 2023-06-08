import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskverse/presentation/List_Screen.dart';
import 'package:taskverse/controllers/dataController.dart';
import 'package:taskverse/controllers/authController.dart';
import 'package:taskverse/services/functions.service.dart';
import 'package:taskverse/shared/widgets/List_Dialog_Box.dart';
import 'package:taskverse/utils/global.dart';
import 'package:taskverse/utils/routes.dart';

class ListViewWidget extends StatelessWidget {
  final AuthController authController = Get.find();
  final DataController data = Get.put(DataController());
  final String uid = Get.find<AuthController>().user!.uid;

  ListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => data.lists.isEmpty
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
                itemCount: data.lists.length,
                separatorBuilder: (context, index) => espaco(10),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => GestureDetector(
                  child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      HapticFeedback.heavyImpact();
                      Functions.deleteLista(uid, data, index);

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
                              'Remover ${data.lists[index].title}?',
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                data.lists[index].title ?? '',
                                style: GoogleFonts.notoSans(
                                  color: colorTextPrimary,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${data.lists[index].task!.length}',
                                    style: GoogleFonts.notoSans(
                                      color: colorNumberPrimary,
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                          index: index,
                          docId: data.lists[index].id,
                        );
                      },
                    );
                  },
                  onTap: () {
                    Navigator.of(context).push(
                      Routes.route(
                        ListScreen(index: index),
                        const Offset(1.0, 0.0),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
