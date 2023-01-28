import 'http_response.dart';

abstract class HttpClient {
  Future<HttpResponse> get(String url, {Map<String, String> params = const {}});
  Future<HttpResponse> post(String url, {dynamic data});
}
