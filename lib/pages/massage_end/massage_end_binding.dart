import 'package:get/get.dart';

import 'massage_end_logic.dart';

class MotionStartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
