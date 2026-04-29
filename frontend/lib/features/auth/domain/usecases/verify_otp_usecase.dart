import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:leksika/core/errors/failures.dart';
import 'package:leksika/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpUsecase {
  VerifyOtpUsecase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, void>> call(VerifyOtpParams params) {
    return repository.verifyOtp(otp: params.otp);
  }
}

class VerifyOtpParams extends Equatable {
  const VerifyOtpParams({
    required this.otp,
  });

  final String otp;

  @override
  List<Object?> get props => [otp];
}
