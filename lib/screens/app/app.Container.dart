import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routers/app.Router.dart';
import '../../routers/pages.Router.dart';
import 'app.Controller.dart';

class AppScreen extends GetWidget<AppController> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child??SizedBox(),
        );
      },),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.prompt().fontFamily
      ),
      darkTheme: ThemeData.dark(),
      locale: Locale('vi', 'VN'),
      initialRoute: AppRouter.home,
      getPages: AppPages.list,
      //initialBinding: AppBinding(),
    );
  }
}