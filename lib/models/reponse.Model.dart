class ResponseModel {
  int? statusCode;
  String? msg;
  int? total;
  dynamic data;

  ResponseModel({this.statusCode,this.msg,this.data,this.total});

  static ResponseModel create() {
    return ResponseModel(msg: "",statusCode: 1);
  }
}