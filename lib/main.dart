import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_massage/db_massage/db_massage.dart';
import 'package:my_massage/pages/feedback/feedback_binding.dart';
import 'package:my_massage/pages/feedback/feedback_view.dart';
import 'package:my_massage/pages/massage_details/massage_details_binding.dart';
import 'package:my_massage/pages/massage_details/massage_details_view.dart';
import 'package:my_massage/pages/massage_main/massage_main_binding.dart';
import 'package:my_massage/pages/massage_main/massage_main_view.dart';
import 'package:my_massage/pages/massage_setting/massage_setting_binding.dart';
import 'package:my_massage/pages/massage_setting/massage_setting_view.dart';
import 'package:my_massage/pages/no_network/no_network_binding.dart';
import 'package:my_massage/pages/no_network/no_network_view.dart';

Color primaryColor = const Color(0xff7b34fe);
Color bgColor = Colors.white;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Get.putAsync(() => DBMassage().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Massage,
      initialRoute: '/massageMain',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

List<GetPage<dynamic>> Massage = [
  GetPage(
      name: '/reload',
      page: () => NoNetworkPage(),
      binding: NoNetworkBinding()),
  GetPage(
      name: '/massageMain',
      page: () => const MassageMainPage(),
      binding: MassageMainBinding()),
  GetPage(
      name: '/massageSetting',
      page: () => MassageSettingPage(),
      binding: MassageSettingBinding()),
  GetPage(
      name: '/massageDetails',
      page: () => MassageDetailsPage(),
      binding: MassageDetailsBinding()),
  GetPage(
      name: '/feedback',
      page: () => FeedbackPage(),
      binding: FeedbackBinding()),
];
