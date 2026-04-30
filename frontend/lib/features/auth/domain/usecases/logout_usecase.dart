import 'package:dartz/dartz.dart';
import 'package:leksika/core/errors/failures.dart';
import 'package:leksika/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository repository;
  LogoutUsecase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}