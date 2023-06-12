import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskverse/controllers/dataController.dart';
import 'package:taskverse/controllers/authController.dart';
import 'package:taskverse/services/database.service.dart';
import 'package:taskverse/shared/widgets/Button_Secondary.dart';
import 'package:taskverse/shared/widgets/widgets.dart';
import 'package:taskverse/utils/global.dart';

final formKey = GlobalKey<FormState>();

class CustomDialogBox extends StatefulWidget {
  final int? index;
  final String? docId;

  const CustomDialogBox({Key? key, this.index, this.docId}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final DataController data = Get.find();
  final AuthController authController = Get.find();
  late TextEditingController titleEditingController;

  @override
  void initState() {
    super.initState();
    String? title = '';

    if (widget.index != null) {
      title = data.lists[widget.index!].title;
    }

    titleEditingController = TextEditingController(text: title);
  }

  @override
  void dispose() {
    super.dispose();
    titleEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: tertiaryColor,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      primaryTextField(
                        context,
                        titleEditingController,
                        1,
                        25,
                        TextInputAction.done,
                        "",
                        taskScreenStyle,
                      ),
                    ],
                  ),
                ),
              ),
              espaco(15),
              Align(
                child: buttonSecondary(() {
                  if (widget.index == null &&
                      formKey.currentState!.validate()) {
                    for (var i = 0; i < data.lists.length; i++) {
                      if (titleEditingController.text.toLowerCase() ==
                          data.lists[i].title!.toLowerCase()) {
                        titleEditingController.text =
                            "${titleEditingController.text} - copia";
                      }
                    }

                    Database().addLista(
                      authController.user!.uid,
                      titleEditingController.text,
                    );

                    Get.back();
                  }

                  if (widget.index != null &&
                      formKey.currentState!.validate()) {
                    var editing = data.lists[widget.index!];
                    editing.title = titleEditingController.text;
                    data.lists[widget.index!] = editing;

                    Database().updateLista(
                      authController.user!.uid,
                      editing.title!,
                      widget.docId!,
                    );
                  }
                }, widget.index == null ? create : update, context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
