class AppException implements Exception {
  final String message;
  final String? prefix;

  AppException([this.message = 'Something went wrong', this.prefix]);

  @override
  String toString() => "$prefix$message";
}

class BadRequestException extends AppException {
  BadRequestException([String message = 'Bad request'])
    : super(message, "Bad Request: ");
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String message = 'Unauthorized'])
    : super(message, "Unauthorized: ");
}

class NotFoundException extends AppException {
  NotFoundException([String message = 'Not Found'])
    : super(message, "Not Found: ");
}

class ConflictException extends AppException {
  ConflictException([String message = 'Conflict'])
    : super(message, "Conflict: ");
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException([String message = 'Internal Server Error'])
    : super(message, "Server Error: ");
}

class NoInternetException extends AppException {
  NoInternetException([String message = 'No Internet'])
    : super(message, "No Internet: ");
}

class UnknownException extends AppException {
  UnknownException([String message = 'Unknown Error'])
    : super(message, "Unknown Error: ");
}
