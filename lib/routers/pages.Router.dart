import 'package:get/get.dart';

import '../screens/home/home.Binding.dart';
import '../screens/home/home.Container.dart';
import 'app.Router.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRouter.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),

  ];
}
