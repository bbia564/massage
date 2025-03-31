import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_massage/main.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:vibration/vibration.dart';

import 'massage_details_logic.dart';

class MassageDetailsPage extends GetView<MassageDetailsLogic> {
  void _controlVibration(int mode) async {
    if (await Vibration.hasVibrator() ?? false) {
      if (controller.isStart != 1) {
        Vibration.cancel();
        return;
      }
    }

    final pattern = [
      [500, 1000, 500, 2000],
      [1000, 500, 500, 500],
      [200, 200, 200, 200]
    ];
    final intensities = [
      [100, 255],
      [150, 200],
      [200, 142]
    ];

    if (await Vibration.hasVibrator() ?? false) {
      if (await Vibration.hasAmplitudeControl() ?? false) {
        Vibration.vibrate(
          pattern: pattern[mode],
          intensities: intensities[mode],
          repeat: -1,
        );
      } else {
        Vibration.vibrate(
          pattern: pattern[mode],
          intensities: intensities[mode],
          repeat: -1,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) async {
        controller.timer?.cancel();
        controller.timer = null;
        if (await Vibration.hasVibrator() ?? false) {
          Vibration.cancel();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Massage'),
          backgroundColor: Colors.white,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
              child: GetBuilder<MassageDetailsLogic>(builder: (_) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Massage duration',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 216,
                  height: 216,
                  alignment: Alignment.center,
                  child: Obx(() {
                    return Text(
                      controller.useTime.value,
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    );
                  }),
                ).decorated(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(108)),
                    border: Border.all(color: primaryColor, width: 12)),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: <Widget>[
                    controller.isStart != 1
                        ? Container(
                            width: double.infinity,
                            height: 54,
                            alignment: Alignment.center,
                            child: Text(
                              controller.isStart == 0 ? 'Start' : 'Continue',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          )
                            .decorated(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8))
                            .gestures(onTap: () {
                            controller.isStart = 1;
                            controller.update();
                            _controlVibration(controller.type);
                            controller.startTimer();
                          })
                        : <Widget>[
                            Expanded(
                                child: Container(
                              width: double.infinity,
                              height: 54,
                              alignment: Alignment.center,
                              child: const Text(
                                'Stop massage',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            )
                                    .decorated(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(8))
                                    .gestures(onTap: () async {
                              if (await Vibration.hasVibrator() ?? false) {
                                Vibration.cancel();
                              }
                              controller.stopTimer();
                            })),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Container(
                              width: double.infinity,
                              height: 54,
                              alignment: Alignment.center,
                              child: const Text(
                                'Pause massage',
                                style: TextStyle(fontSize: 15),
                              ),
                            )
                                    .decorated(
                                        color: const Color(0xfff7f7f7),
                                        borderRadius: BorderRadius.circular(8))
                                    .gestures(onTap: () async {
                              if (await Vibration.hasVibrator() ?? false) {
                                Vibration.cancel();
                              }
                              controller.pauseTimer();
                            }))
                          ].toRow(),
                    <Widget>[
                      Container(
                        width: 11,
                        height: 11,
                      ).decorated(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(6.5)),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Selection mode',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ].toRow().marginSymmetric(vertical: 20),
                    Container(
                      width: double.infinity,
                      height: 54,
                      padding: const EdgeInsets.all(10),
                      child: <Widget>[
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Mode 1',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: controller.type == 0
                                    ? Colors.white
                                    : const Color(0xff9d9d9d)),
                          ),
                        )
                                .decorated(
                                    borderRadius: BorderRadius.circular(17),
                                    color: controller.type == 0
                                        ? primaryColor
                                        : Colors.transparent)
                                .gestures(onTap: () {
                          controller.type = 0;
                          controller.update();
                          _controlVibration(0);
                        })),
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Mode 2',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: controller.type == 1
                                    ? Colors.white
                                    : const Color(0xff9d9d9d)),
                          ),
                        )
                                .decorated(
                                    borderRadius: BorderRadius.circular(17),
                                    color: controller.type == 1
                                        ? primaryColor
                                        : Colors.transparent)
                                .gestures(onTap: () {
                          controller.type = 1;
                          controller.update();
                          _controlVibration(1);
                        })),
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Mode 3',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: controller.type == 2
                                    ? Colors.white
                                    : const Color(0xff9d9d9d)),
                          ),
                        )
                                .decorated(
                                    borderRadius: BorderRadius.circular(17),
                                    color: controller.type == 2
                                        ? primaryColor
                                        : Colors.transparent)
                                .gestures(onTap: () {
                          controller.type = 2;
                          controller.update();
                          _controlVibration(2);
                        }))
                      ].toRow(),
                    ).decorated(
                        color: const Color(0xfff7f7f7),
                        borderRadius: BorderRadius.circular(27))
                  ].toColumn(),
                ).decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(color: const Color(0xffe6e6e6), width: 1))
              ].toColumn(),
            );
          }).marginAll(15)),
        ).decorated(
            gradient: const LinearGradient(
                colors: [Color(0xffece6ff), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            image: const DecorationImage(
                image: AssetImage('assets/bg.webp'), fit: BoxFit.fill)),
      ),
    );
  }
}
