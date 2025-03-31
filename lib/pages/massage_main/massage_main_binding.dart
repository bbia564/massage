import 'package:get/get.dart';

import 'massage_main_logic.dart';

class MassageMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MassageMainLogic());
  }
}
