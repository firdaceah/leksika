class ServerException implements Exception {
  final String message;
  final int? statusCode;
  ServerException({this.message = 'Server error', this.statusCode});
}

class UnauthorizedException implements Exception {}

class EmailNotVerifiedException implements Exception {}
