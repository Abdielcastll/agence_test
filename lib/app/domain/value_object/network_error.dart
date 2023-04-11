class ApiException implements Exception {
  ApiException({required this.code, this.message = ''});
  String? message;
  int code;

  @override
  String toString() {
    return message!;
  }
}
