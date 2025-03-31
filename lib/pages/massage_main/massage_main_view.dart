import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_massage/main.dart';
import 'package:styled_widget/styled_widget.dart';

import 'massage_main_logic.dart';

class MassageMainPage extends StatefulWidget {
  const MassageMainPage({Key? key}) : super(key: key);

  @override
  State<MassageMainPage> createState() => _MassageMainPageState();
}

class _MassageMainPageState extends State<MassageMainPage> {
  MassageMainLogic controller = Get.find();

  void checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
     Get.toNamed('/reload');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        child: SafeArea(
            child: <Widget>[
          <Widget>[
            const Text(
              'My massage',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.settings,
              size: 30,
              color: primaryColor,
            ).gestures(onTap: () {
              Get.toNamed('/massageSetting');
            })
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 145,
            padding: const EdgeInsets.all(30),
            child: <Widget>[
              Image.asset(
                'assets/icon0.webp',
                width: 53,
                height: 50,
                fit: BoxFit.cover,
              ),
              Container(
                width: 191,
                height: 60,
                alignment: Alignment.center,
                child: Text(
                  'Start massage',
                  style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              )
                  .decorated(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30))
                  .gestures(onTap: () {
                Get.toNamed('/massageDetails')?.then((_) {
                  controller.getData();
                });
              })
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
          ).decorated(
              gradient: const LinearGradient(
                  colors: [Color(0xff9e66f8), Color(0xff762cff)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
              borderRadius: BorderRadius.circular(26)),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: <Widget>[
              <Widget>[
                const SizedBox(
                  width: 11,
                  height: 11,
                ).decorated(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(6.5)),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Usage record',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ].toRow(),
              Divider(
                height: 25,
                color: Colors.grey.shade300,
              ),
              Expanded(child: Obx(() {
                return controller.list.value.isEmpty
                    ? Center(
                        child: <Widget>[
                          Image.asset(
                            'assets/noData.webp',
                            width: 92,
                            height: 95,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'No data',
                            style: TextStyle(color: Colors.grey),
                          )
                        ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
                      )
                    : ListView.builder(
                        itemCount: controller.list.value.length,
                        itemBuilder: (_, index) {
                          final entity = controller.list.value[index];
                          return <Widget>[
                            <Widget>[
                              const Text(
                                'Duration of use',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                entity.useTime,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                entity.createdTimeStr,
                                // "03/30/2025",
                                style: const TextStyle(color: Colors.grey),
                              )
                            ].toRow(),
                            Divider(
                              height: 25,
                              color: Colors.grey.shade300,
                            ),
                          ].toColumn();
                        });
              }))
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
          ).decorated(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xffe6e6e6))))
        ].toColumn()),
      ).decorated(
          gradient: const LinearGradient(
              colors: [Color(0xffece6ff), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    );
  }
}
