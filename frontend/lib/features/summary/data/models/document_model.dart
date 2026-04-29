import 'package:leksika/features/summary/domain/entities/document_entity.dart';

class DocumentModel extends DocumentEntity {
  const DocumentModel({
    required super.id,
    required super.title,
    required super.summary,
    required super.createdAt,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] as String?) ?? '',
      summary: (json['summary'] as String?) ?? '',
      createdAt: _parseDate(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  static DateTime? _parseDate(dynamic value) {
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}
