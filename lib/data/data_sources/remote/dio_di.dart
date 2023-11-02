import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';

import '../../../injection_container.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/json_interceptor.dart';


abstract class DioDi {
  Dio get dio {
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    dio.interceptors.add(JsonResponseConverter());
    dio.interceptors.add(ErrorInterceptor());
    dio.interceptors.add(LoggyDioInterceptor(
      responseBody: true,
      requestBody: true,
    ));

    return dio;
  }
}
