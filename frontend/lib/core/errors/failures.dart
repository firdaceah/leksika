import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error']) : super(message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([String message = 'Unauthorized']) : super(message);
}

class EmailNotVerifiedFailure extends Failure {
  const EmailNotVerifiedFailure([String message = 'Email not verified'])
      : super(message);
}
