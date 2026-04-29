import 'package:dartz/dartz.dart';
import 'package:leksika/core/errors/failures.dart';
import 'package:leksika/features/auth/domain/repositories/auth_repository.dart';

class ResendOtpUsecase {
  ResendOtpUsecase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, void>> call() {
    return repository.resendOtp();
  }
}
