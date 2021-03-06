import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpProvider {
  HttpProvider._();

  static final HttpProvider http = HttpProvider._();

  Dio _dio;

  Dio get dio {
    if (_dio != null) return _dio;
    _dio = new Dio();
    return _dio;
  }

  String get programsEndpoint => '/programs';
  String get rewardsEndpoint => '/rewards';
  String get locationsEndpoint => '/locations';
  String get rewardsAndLocationsEndpoint => '/rewardslocations';
  String get rewardOriginsEndpoint => '/rewardorigins';

  initHttp(baseUrl) {
    final Dio d = dio;
    d.options.baseUrl = baseUrl;
  }

  Future<dynamic> get({@required String api, CancelToken token}) async {
    if (token != null) {
      return await dio.get(api, cancelToken: token).catchError((error) async {
        await dio.get(api, cancelToken: token);
      });
    } else {
      return await dio.get(api).catchError((error) async {
        await dio.get(api, cancelToken: token);
      });;
    }
  }

  void cancel(CancelToken token) {
    token.cancel("cancelled");
  }
}
