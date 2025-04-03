// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:myparkingappadmin/repository/authRepository.dart';


class DioClient {
  final Dio dio = Dio();
  final AuthRepository authRepository = AuthRepository();

  DioClient() {
    dio.options.baseUrl = "https://localhost/myparkingapp/";
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    // Interceptor để tự động gắn token
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        String? token = await authRepository.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },

      onError: (DioException err, ErrorInterceptorHandler handler) async {
        if (err.response?.statusCode == 401) {
          print("Token expired, refreshing...");
          await authRepository.refreshAccessToken();
          String? newToken = await authRepository.getAccessToken();

          if (newToken != null) {
            err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

            // Thực hiện lại request sau khi có token mới
            final clonedRequest = await dio.request(
              err.requestOptions.path,
              options: Options(
                method: err.requestOptions.method,
                headers: err.requestOptions.headers,
              ),
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
            );

            handler.resolve(clonedRequest);
            return;
          }
        }
        handler.next(err);
      },
    ));
  }
}
