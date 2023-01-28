// ignore_for_file: public_member_api_docs, sort_constructors_first
class HttpException {
  final String message;
  final int statusCode;

  const HttpException({
    required this.message,
    required this.statusCode,
  });
}
