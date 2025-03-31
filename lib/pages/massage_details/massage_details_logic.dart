import 'dart:async';

import 'package:get/get.dart';
import 'package:my_massage/db_massage/db_massage.dart';
import 'package:my_massage/db_massage/massage_entity.dart';

class MassageDetailsLogic extends GetxController {

  DBMassage dbMassage = Get.find();

  int type = 0;

  int timeUp = 0;
  var useTime = '00:00'.obs;

  int isStart = 0;

  Timer? timer;

  startTimer() {
    timer?.cancel();
    timer = null;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      timeUp++;
      final minute = timeUp ~/ 60;
      final second = timeUp % 60;
      useTime.value = '${minute < 10 ? '0$minute' : minute}:${second < 10 ? '0$second' : second}';
    });
  }

  stopTimer() {
    addData();
    timer?.cancel();
    timer = null;
    timeUp = 0;
    useTime.value = '00:00';
    isStart = 0;
    update();
  }

  pauseTimer() {
    timer?.cancel();
    timer = null;
    isStart = 2;
    update();
  }

  addData() async {
    await dbMassage.insertMassageData(MassageEntity(
      id: 0,
      createdTime: DateTime.now(),
      useTime: useTime.value,
    ));
  }

}
