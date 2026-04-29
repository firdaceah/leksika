import 'package:leksika/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.emailVerifiedAt,
    super.token,
  });

  factory UserModel.fromAuthResponse(Map<String, dynamic> json) {
    final userJson = json['user'] as Map<String, dynamic>? ?? <String, dynamic>{};
    return UserModel(
      id: (userJson['id'] as num?)?.toInt() ?? 0,
      name: (userJson['name'] as String?) ?? '',
      email: (userJson['email'] as String?) ?? '',
      emailVerifiedAt: _parseDate(userJson['email_verified_at']),
      token: json['token'] as String?,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] as String?) ?? '',
      email: (json['email'] as String?) ?? '',
      emailVerifiedAt: _parseDate(json['email_verified_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
    };
  }

  static DateTime? _parseDate(dynamic value) {
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}
