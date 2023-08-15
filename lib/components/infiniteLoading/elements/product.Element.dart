import 'package:flutter/material.dart';
import 'package:test_flutter/models/product.Model.dart';

class ProductElement extends StatelessWidget {
  const ProductElement({super.key,required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title??""),
      subtitle: Text(product.description??""),
      trailing: Text(product.price.toString()),
    );  
  }
}