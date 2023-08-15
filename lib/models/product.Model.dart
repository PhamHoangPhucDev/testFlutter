class ProductModel {
  int? id;
  String? title;
  String? description;//mô tả
  int? price;

  ProductModel({this.description,this.id,this.price,this.title});

  factory ProductModel.fromJson(Map<String, dynamic>? json) {
    late ProductModel result = ProductModel();
    if (json != null) {
      result = ProductModel(
        id : (json["id"]) ?? "",
        title : (json["title"]) ?? "",
        description: (json["description"]) ?? "",
        price: (json["price"]) ?? 0,
      );
    }
    return result;
  }

  static List<ProductModel> fromJsonList(List? list) {
    if (list == null) return [];
    return list.map((item) => ProductModel.fromJson(item)).toList();
  }
}