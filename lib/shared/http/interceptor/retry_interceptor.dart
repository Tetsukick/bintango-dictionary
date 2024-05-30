import 'dart:io';

import 'package:bintango_indonesian_dictionary/shared/http/interceptor/dio_connectivity_request_retrier.dart';
import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });
  final DioConnectivityRequestRetrier requestRetrier;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (_shouldRetry(err)) {
      try {
        requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {}
    }
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.connectionTimeout &&
        err.error != null &&
        err.error is SocketException;
  }
}
