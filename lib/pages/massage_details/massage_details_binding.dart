import 'package:get/get.dart';

import 'massage_details_logic.dart';

class MassageDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MassageDetailsLogic());
  }
}
