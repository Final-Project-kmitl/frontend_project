abstract class Failure {
  final String message;
  Failure({required this.message});
}

class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message: message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message: message);
}
