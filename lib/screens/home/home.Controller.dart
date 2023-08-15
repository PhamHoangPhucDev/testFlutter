import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product.Model.dart';
import '../../providers/app.Provider.dart';

class HomeController extends GetxController {
  static HomeController get initance => Get.find();
  late AppProvider appProvider;
  final searchController = TextEditingController();
  Timer? debounce;

  RxBool hasMore = true.obs;
  RxBool isLoading = false.obs;
  RxList<ProductModel> listProduct = RxList.empty(growable: true);

  @override
  void onInit() {
    appProvider = AppProvider();
    super.onInit();
  }

  @override
  void onReady() {
    getDatas();
    super.onReady();
  }

  Future getDatas({int? limit = 20,int? skip = 0,String? title = ''}) async{
    isLoading.value = true;
    var result = await appProvider.getDatas(limit: limit,skip: skip,title: title);
    isLoading.value = false;
    if(result.statusCode == 0){
      listProduct.addAll(result.data);
      hasMore.value = (listProduct.length < (result.total??0));
    } else {
      Get.snackbar("Thông báo", result.msg??"");
    }
  }

  void searchProduct(String query) async {
    if (debounce != null) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      loadMore(clearCachedData: true);
    });
  }

    Future<void> refreshData() {
    return loadMore(clearCachedData: true);
  }

  Future<void> loadMore({bool clearCachedData = false}) {
    if (clearCachedData) {
      listProduct.clear();
      hasMore.value = true;
      return getDatas(limit: 20,title: searchController.text);
    }
    if (isLoading.value || !hasMore.value) {
      return Future.value();
    }
    return getDatas(limit: 20,skip: 20,title: searchController.text);
  }
}