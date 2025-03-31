import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'massage_end_logic.dart';

class MassageEndView extends GetView<PageLogic> {
  const MassageEndView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.quitzon.value
              ? const CircularProgressIndicator(color: Colors.purple)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.rqoym();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
