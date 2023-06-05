import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskverse/shared/widgets/List_View_Task_Widget.dart';
import 'package:taskverse/utils/global.dart';
import 'package:taskverse/utils/routes.dart';

GestureDetector cardWidget(context, title, infoText, data, icon) {
  return GestureDetector(
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 35.0,
                color: greyColor,
              ),
              const SizedBox(width: 5.0),
              Obx(
                () => Text(
                  '${data.length}',
                  style: GoogleFonts.notoSans(fontSize: 20.0, color: greyColor),
                ),
              ),
              const SizedBox(width: 5.0),
              Text(
                title,
                style: GoogleFonts.notoSans(fontSize: 20.0, color: greyColor),
              ),
            ],
          ),
        ),
      ),
    ),
    onTap: () {
      Navigator.of(context).push(Routes.route(
          ListViewFilteredWidget(
            title: title,
            data: data,
            infoText: infoText,
            icon: icon,
          ),
          const Offset(1.0, 0.0)));
    },
  );
}
