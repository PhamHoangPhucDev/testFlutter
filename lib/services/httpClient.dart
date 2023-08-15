
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;

import 'dioFirebasePerformance.Interceptor.dart';


class HttpClient {
  static final HttpClient _singleton = HttpClient._();
  static HttpClient get instance => _singleton;
  HttpClient._();
  String serverURL = "";
  
  Dio get httpClient {
    serverURL = "https://dummyjson.com";
    Dio dio = Dio(setupOptionDio(serverURL));
    print(dio.options.baseUrl);
    DioFirebasePerformanceInterceptor dioFirebasePerformanceInterceptor = DioFirebasePerformanceInterceptor();
    dio.interceptors.add(dioFirebasePerformanceInterceptor);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options, RequestInterceptorHandler handler)=> requestInterceptor(options,handler),
      onResponse: (Response response,ResponseInterceptorHandler handler)=> responseInterceptor(response,handler),
      onError: (DioException e, handler)=>errorInterceptor(e,handler)
    ));
    return dio;
  }
  

 Future<dynamic> requestInterceptor( RequestOptions options, RequestInterceptorHandler handler) async
  {
      // options.headers['Content-Type']="application/json";
      options.contentType = "application/json";
    return handler.next(options);
  }

  dynamic responseInterceptor(Response response,ResponseInterceptorHandler handler) async {
    try{
    }
    catch(ex){
      print("Lỗi http:"+ex.toString());
    }
    return handler.next(response); // continue
  }


  dynamic errorInterceptor(DioException dioError,ErrorInterceptorHandler handler) async{
    print( dioError.message);
    Response temp = Response(statusCode: -2,requestOptions: RequestOptions(path: ''));
    temp = Response(statusCode: -1,data:_handleError(dioError), requestOptions: RequestOptions(path: ''));
    return handler.resolve(temp);
  }

  BaseOptions setupOptionDio(String serverURL) {
    return BaseOptions(
      baseUrl: serverURL,
      headers: {
        "Content-Type": "application/json",
        "Accept":"*/*",
        "Access-Control-Allow-Origin": "*",
        "Connection":"keep-alive"
      }
    );
  }
}

String _handleError(DioException dioError) {
    String result = "Kết nối internet không ổn định, vui lòng thử lại !";
    try{
      switch (dioError.type) {
        case DioExceptionType.badResponse:
          switch (dioError.response!.statusCode){
            case 404:
              result= '400 - Not found';
              break;
            case 401:
              result ='401 - Unauthorized.';
              break;
          }
          break;
        case DioExceptionType.cancel:
          result = 'Kết nối bị đóng !';
          break;
        case DioExceptionType.connectionTimeout:
          result = 'Kết nối internet không ổn định, vui lòng thử lại !';
          break;
        case DioExceptionType.receiveTimeout:
          result = 'Kết nối internet không ổn định, vui lòng thử lại !';
          break;
        case DioExceptionType.sendTimeout:
          result = 'Kết nối internet không ổn định, vui lòng thử lại !';
          break;
        // case DioExceptionType.other:
        //   if ((dioError.message).contains("SocketException")) {
        //     result = 'Không có kết nối internet, vui lòng kết nối lại !';
        //   }
        //   else{
        //     result = "Kết nối internet không ổn định, vui lòng thử lại !";
        //   }
          // break;
        default:
        return 'Kết nối internet không ổn định, vui lòng thử lại !';
      }
    }
    catch(ex){
      print(ex);
    }
    return result;
  }
