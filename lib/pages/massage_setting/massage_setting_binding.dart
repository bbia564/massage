import 'package:get/get.dart';

import 'massage_setting_logic.dart';

class MassageSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MassageSettingLogic());
  }
}
