import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_massage/db_massage/db_massage.dart';
import 'package:my_massage/pages/massage_main/massage_main_logic.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MassageSettingLogic extends GetxController {

  DBMassage dbMassage = Get.find();

  cleanMassageData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all records?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbMassage.cleanMassageData();
            MassageMainLogic mainLogic = Get.find();
            mainLogic.getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutMassageUS(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 76,
        height: 76,
      ),
      children: [
        const Text(
            """We can provide you with a simple massage"""),
      ],
      context: context,
    );
  }

}
