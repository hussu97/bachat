import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpProvider {
  HttpProvider._();

  static final HttpProvider http = HttpProvider._();

  Dio _dio;

  Dio get dio {
    if(_dio != null) return _dio;
    _dio = new Dio();
    return _dio;
  }

  String get programsEndpoint => '/programs';

  initHttp(baseUrl) {
    final Dio d = dio;
    d.options.baseUrl = baseUrl;
  }

  Future<dynamic> get({@required String api,CancelToken token}) async{
    if (token!=null){
      return await dio.get(api,cancelToken: token);
    } else {
      return await dio.get(api);
    }
  }

  void cancel(CancelToken token) {
    token.cancel("cancelled");
  }
}