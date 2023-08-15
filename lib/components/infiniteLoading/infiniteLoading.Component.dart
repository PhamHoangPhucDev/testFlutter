import 'package:flutter/material.dart';
import 'package:test_flutter/models/product.Model.dart';

import 'elements/product.Element.dart';

class InfiniteLoadingComponent extends StatefulWidget {
  InfiniteLoadingComponent({super.key,required this.listPrd,required this.loadMore,required this.refresh,required this.hasMore,required this.isLoading});
  List<ProductModel> listPrd;
  Future<void> Function() refresh;
  VoidCallback loadMore;
  bool hasMore;
  bool isLoading;

  @override
  State<InfiniteLoadingComponent> createState() => _InfiniteLoadingConponemtState();
}

class _InfiniteLoadingConponemtState extends State<InfiniteLoadingComponent> {

  final scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset){
        widget.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildIndicator();
  }

  Widget buildIndicator(){
    Widget result = const SizedBox();
    if (widget.listPrd.isEmpty) {
      if(widget.isLoading){
        result = const Center(child: CircularProgressIndicator(),);
      } else {
        result = const Center(child: Text("Không có dữ liệu"),);
      }
    } else {
      result = RefreshIndicator(
        onRefresh: widget.refresh,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          controller: scrollController,
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: (widget.listPrd.length) + 1,
          itemBuilder: (context, index) {
            if(index < widget.listPrd.length) {
              return ProductElement(product: widget.listPrd[index]);
            } else if (widget.hasMore) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(child: CircularProgressIndicator(),),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(child: Text('Không có gì để tải!')),
              );
            }
          }, 
        )
      );
    }
    return result;
  }
}