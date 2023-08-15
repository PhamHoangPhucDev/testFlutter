import 'package:get/get.dart';

import 'app.Controller.dart';

class AppBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>AppController());
  }
}