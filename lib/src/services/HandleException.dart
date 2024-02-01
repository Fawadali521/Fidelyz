
class HandleException implements Exception {
  final _message;
  final _prefix;

  HandleException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix $_message';
  }
}

class InternetException extends HandleException {
  InternetException([String? message]) : super(message, 'No Internet');
}

class RequestTimeOut extends HandleException {
  RequestTimeOut([String? message]) : super(message, 'Request Time Out');
}

class ServerException extends HandleException {
  ServerException([String? message]) : super(message, 'Internal server error');
}

class FetchDataException extends HandleException {
  FetchDataException([String? message]) : super(message, '');
}

class ClientExceptions extends HandleException {
  ClientExceptions([String? message]) : super(message, '');
}
