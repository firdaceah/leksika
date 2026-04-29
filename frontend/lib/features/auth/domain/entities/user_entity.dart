import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.token,
  });

  final int id;
  final String name;
  final String email;
  final DateTime? emailVerifiedAt;
  final String? token;

  bool get isEmailVerified => emailVerifiedAt != null;

  @override
  List<Object?> get props => [id, name, email, emailVerifiedAt, token];
}
