import 'package:leksika/features/summary/domain/entities/document_entity.dart';

class DocumentModel extends DocumentEntity {
  const DocumentModel({
    required super.id,
    required super.title,
    required super.summary,
    required super.createdAt,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    final titleField = json['file_name'] as String? ?? json['title'] as String? ?? 'Tanpa Judul';

    String summaryText = '';
    if (json['summary'] != null && json['summary'] is Map) {
      summaryText = json['summary']['summary_text'] as String? ?? '';
    } else if (json['summary'] is String) {
      summaryText = json['summary'] as String;
    }

    return DocumentModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: titleField,
      summary: summaryText,
      createdAt: _parseDate(json['created_at']) ?? DateTime.now(),
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