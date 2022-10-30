import 'dart:developer';
import 'package:datacoup/data/configs/app_settings_config.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class DioInstance {
  static final DioInstance _singleton = DioInstance._internal();

  late Dio dio;
  factory DioInstance() {
    return _singleton;
  }

  DioInstance._internal() {
    Map<String, dynamic> serverConfig = appSettingsDev;
    BaseOptions options = BaseOptions(baseUrl: serverConfig["baseURL"]);

    options.connectTimeout = 70000;
    options.receiveTimeout = 70000;
    dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, handler) async {
        log("${options.method} ${options.path}");
        options.headers['Authorization'] = await fetchAuthToken();
        // options.headers['X-Ode-AppOrigin'] = "datacoup";
        options.contentType = Headers.jsonContentType;
        return handler.next(options);
      },
      onResponse: (Response response, handler) {
        log("${response.statusCode}");
        return handler.resolve(response);
      },
      onError: (DioError e, handler) async {
        log(e.error);
        return handler.reject(e);
      },
    ));
  }

// to get token..
  Future<String> fetchAuthToken() async {
    String token = GetStorage().read("idToken");
    log("token*** $token");
    return token.toString();
  }
}
