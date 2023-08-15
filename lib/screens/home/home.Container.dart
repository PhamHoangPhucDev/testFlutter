import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/fields/textField.Component.dart';
import '../../components/infiniteLoading/infiniteLoading.Component.dart';
import 'home.Controller.dart';

class HomeScreen extends GetWidget<HomeController> {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search & Filter'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextFieldComponent(
              textController: controller.searchController,
              hintText: 'Từ khóa',
              onChange: controller.searchProduct,
            ),
          ),
          Obx(() => Expanded(
            child: InfiniteLoadingComponent(
              listPrd: controller.listProduct.value,
              hasMore: controller.hasMore.value,
              isLoading: controller.isLoading.value,
              loadMore: controller.loadMore,
              refresh: controller.refreshData,
            )
          )
          )
        ],
      ),
    );
  }
}