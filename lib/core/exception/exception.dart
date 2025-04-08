abstract class Failure {}

class ServerFailure extends Failure {}

class ParsingFailure extends Failure {}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}
