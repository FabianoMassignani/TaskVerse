import 'package:flutter/material.dart';
import 'package:taskverse/shared/widgets/Button_Primary.dart';
import 'package:taskverse/utils/global.dart';
import '../controllers/authController.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(configuracoes, style: barTextStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Icon(
                Icons.account_circle,
                size: 100,
                color: basicColor,
              ),
            ),
            espaco(15),
            Center(
                child: Text(
              authController.user!.email ?? '',
              style: const TextStyle(fontSize: 20.0, color: Colors.white),
            )),
            espaco(30),
            buttonPrimary(
              () {
                authController.signOut(context);
              },
              sair,
            ),
          ],
        ),
      ),
    );
  }
}



       //        showModalBottomSheet<void>(
                  //   backgroundColor: redColor,
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return Container(
                  //       padding: const EdgeInsets.only(top: 15.0),
                  //       height: 260,
                  //       child: ListView(children: [
                  //         const SizedBox(height: 10.0),
                  //         Center(
                  //           child: Icon(
                  //             Icons.account_circle,
                  //             size: 40.0,
                  //             color: basicColor,
                  //           ),
                  //         ),
                  //         const SizedBox(height: 15.0),
                  //         Center(
                  //             child: Text(
                  //           authController.user!.email ?? '',
                  //           style: accountTextStyle,
                  //         )),
                  //         const SizedBox(height: 15.0),
                  //         primaryDivider,
                  //         ListTile(
                  //           title: Text(
                  //             "Sign out",
                  //             style: optionsTextStyle,
                  //           ),
                  //           leading: Icon(
                  //             Icons.logout,
                  //             color: basicColor,
                  //           ),
                  //           onTap: () {
                  //             Navigator.pop(context);
                  //             authController.signOut(context);
                  //           },
                  //         ),
                  //         ListTile(
                  //           title: Text(
                  //             "Delete account",
                  //             style: optionsTextStyle,
                  //           ),
                  //           leading: Icon(
                  //             Icons.delete,
                  //             color: basicColor,
                  //           ),
                  //           onTap: () async {
                  //             Navigator.pop(context);
                  //             await showDialog<String>(
                  //               barrierDismissible: true,
                  //               context: context,
                  //               builder: (BuildContext context) => AlertDialog(
                  //                 backgroundColor:
                  //                     const Color.fromARGB(255, 37, 37, 37),
                  //                 title: const Text('Delete account',
                  //                     style: TextStyle(color: Colors.white)),
                  //                 content: const Text(
                  //                     'Are you sure you want to delete your account?',
                  //                     style: TextStyle(
                  //                         color: Color.fromARGB(
                  //                             255, 187, 187, 187))),
                  //                 actions: <Widget>[
                  //                   TextButton(
                  //                     onPressed: () {
                  //                       Navigator.pop(context, 'Cancel');
                  //                     },
                  //                     child: Text('Cancel',
                  //                         style:
                  //                             TextStyle(color: basicColor)),
                  //                   ),
                  //                   TextButton(
                  //                     onPressed: () async {
                  //                       Navigator.pop(context, 'Ok');
                  //                       Get.to(const DeleteScreen());
                  //                     },
                  //                     child: Text('OK',
                  //                         style:
                  //                             TextStyle(color: basicColor)),
                  //                   ),
                  //                 ],
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ]),
                  //     );
                  //   },
                  // );