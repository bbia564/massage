import 'package:get/get.dart';
import 'package:my_massage/db_massage/db_massage.dart';
import 'package:my_massage/db_massage/massage_entity.dart';

class MassageMainLogic extends GetxController {

  DBMassage dbMassage = Get.find();

  var list = <MassageEntity>[].obs;

  void getData() async {
    list.value = await dbMassage.getMassageAllData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
