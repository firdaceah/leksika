import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:leksika/core/errors/failures.dart';
import 'package:leksika/features/auth/domain/entities/user_entity.dart';
import 'package:leksika/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  RegisterUsecase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, UserEntity>> call(RegisterParams params) {
    return repository.register(
      name: params.name,
      email: params.email,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
    );
  }
}

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  @override
  List<Object?> get props => [name, email, password, passwordConfirmation];
}
