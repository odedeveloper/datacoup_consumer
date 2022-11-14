import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';

class DioInstance {
  static final DioInstance _singleton = DioInstance._internal();

  late Dio dio;
  factory DioInstance() {
    return _singleton;
  }

  DioInstance._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: GlobalConfiguration().get("baseURL"),
    );

    options.connectTimeout = 70000;
    options.receiveTimeout = 70000;
    dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, _handler) async {
        print("${options.method} ${options.path}");
        options.headers['Authorization'] = await fetchAuthToken();
        // options.headers['X-Ode-AppOrigin'] = "datacoup";
        options.contentType = Headers.jsonContentType;

        return _handler.next(options);
      },
      onResponse: (Response response, _handler) {
        print(response.statusCode);
        return _handler.resolve(response);
      },
      onError: (DioError e, _handler) async {
        print(e.error);

        return _handler.reject(e);
      },
    ));
  }

// to get token..
  Future<String?> fetchAuthToken() async {
    String token = GetStorage().read("idToken") ?? "";
    log("token*** $token");
    return token.toString();
  }
}
