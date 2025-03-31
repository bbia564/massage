import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'massage_setting_logic.dart';

class MassageSettingPage extends GetView<MassageSettingLogic> {
  const MassageSettingPage({super.key});

  Widget _item(int index, BuildContext context) {
    final titles = [
      'Massager connection',
      'Clean all records',
      'Feedback',
      'Version'
    ];
    return Container(
      color: Colors.transparent,
      height: 40,
      child: <Widget>[
        Text(titles[index]),
        <Widget>[
          Visibility(
            visible: index == 0,
            child: const Text(
              'Unconnected',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          index == 3 ? const Text("1.0.0",style: TextStyle(color: Colors.grey),).paddingOnly(right: 10) : const Icon(
            Icons.keyboard_arrow_right,
            size: 20,
            color: Colors.grey,
          )
        ].toRow(mainAxisAlignment: MainAxisAlignment.end)
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ).gestures(onTap: () {
      switch (index) {
        case 0:
          break;
        case 1:
          controller.cleanMassageData();
          break;
        case 2:
          Get.toNamed('/feedback');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: <Widget>[
                _item(0, context),
                _item(1, context),
                _item(2, context),
                _item(3, context),
              ].toColumn(
                  separator: Divider(
                height: 15,
                color: Colors.grey.withOpacity(0.3),
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12))
          ].toColumn(),
        ).marginAll(15)),
      ).decorated(
          gradient: const LinearGradient(
              colors: [Color(0xffece6ff), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    );
  }
}
