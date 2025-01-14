import 'package:dio/dio.dart';

class ApiService {
  static Future<Response> request(
    String path, {
    Map<String, dynamic>? params,
    Object? body,
    Object? putBody,
    Object? deleteBody,
    void Function(int, int)? onReceiveProgress,
    String? auth,
    bool isPostWithoutBody = false
  }) async {
    Response response;
    Dio dio = Dio(BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      validateStatus: (status) {
        return true;
      },
      baseUrl: "https://7688-187-235-135-111.ngrok-free.app/api"
    ));

    try {
      dio.options.headers['Authorization'] = 'Bearer $auth';

      if (deleteBody != null) {
        response = await dio.delete(
          path,
          data: deleteBody,
          queryParameters: params,
        );
      } else if (putBody != null) {
        response = await dio.put(
          path,
          data: putBody,
          queryParameters: params,
          onReceiveProgress: onReceiveProgress,
        );
      } else if (body != null) {
        response = await dio.post(
          path,
          data: body,
          queryParameters: params,
          onReceiveProgress: onReceiveProgress,
        );
      } else if (isPostWithoutBody) {
        response = await dio.post(
          path,
        );
      } else {
        response = await dio.get(
          path,
          queryParameters: params,
        );
      }
    } on DioException catch (e) {
      response = Response(
          requestOptions: e.requestOptions,
          statusCode: 510,
          statusMessage: e.message);
    }
    return response;
  }
}
