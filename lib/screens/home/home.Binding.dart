import 'package:get/get.dart';
import 'home.Controller.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>HomeController());
  }
}