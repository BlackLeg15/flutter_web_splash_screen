import 'package:dio/dio.dart';

import '../../interfaces/http_client/http_client.dart';
import '../../interfaces/http_client/http_exception.dart';
import '../../interfaces/http_client/http_response.dart';

class HttpClientDioImp implements HttpClient {
  final Dio dioClient;

  const HttpClientDioImp(this.dioClient);

  @override
  Future<HttpResponse> get(String url, {Map<String, String> params = const {}}) async {
    try {
      final result = await dioClient.get(url, queryParameters: params);
      return HttpResponse(data: result.data);
    } on DioError catch (e) {
      throw HttpException(message: e.message, statusCode: e.response?.statusCode ?? 404);
    }
  }

  @override
  Future<HttpResponse> post(String url, {dynamic data}) async {
    try {
      final result = await dioClient.post(url, data: data);
      return HttpResponse(data: result.data);
    } on DioError catch (e) {
      throw HttpException(message: e.message, statusCode: e.response?.statusCode ?? 404);
    }
  }
}
