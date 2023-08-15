import 'package:dio/dio.dart';

import '../models/product.Model.dart';
import '../models/reponse.Model.dart';
import '../services/httpClient.dart';

class AppProvider{
  Dio httpClient = HttpClient.instance.httpClient;
  AppProvider(){}

  Future<ResponseModel> getDatas({int? limit = 20,int? skip = 0,String? title = '',bool search = false}) async {
    ResponseModel result = ResponseModel.create();
    try {
      var responses = await httpClient.get("/products/search?q=$title&limit=$limit&skip=$skip", data: {});
      if (responses.statusCode == 200 && responses.data != null) {
        if (responses.data["products"] != null) {
          result.statusCode = 0;
          result.msg = "";
          result.total = responses.data["total"];
          result.data = ProductModel.fromJsonList(responses.data["products"]);
        } else {
          result.statusCode = 1;
          result.msg = responses.data["sysName"];
        }
      }
      else if(responses.statusCode ==-1){
        result.statusCode =1;
        result.msg = responses.data.toString();
      } 
      else {
        result.statusCode = 1;
        result.msg = "Server error ${responses.statusCode}";
      }
    } catch (ex) {
      result.statusCode = 1;
      result.msg = ex.toString();
    }
    return result;
  }

}
