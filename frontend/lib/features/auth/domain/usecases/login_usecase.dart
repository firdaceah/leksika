import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:leksika/core/errors/failures.dart';
import 'package:leksika/features/auth/domain/entities/user_entity.dart';
import 'package:leksika/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  LoginUsecase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    return repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  const LoginParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
