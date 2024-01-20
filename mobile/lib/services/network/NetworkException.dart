class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid (400): ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised (401): ");
}

class ForbiddenException extends AppException {
  ForbiddenException([message]) : super(message, "Forbidden (403): ");
}

class NotFoundException extends AppException {
  NotFoundException([message]) : super(message, "Not found (404): ");
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException([message]) : super(message, "Internal server error (500): ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}