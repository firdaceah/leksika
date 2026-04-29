import 'package:equatable/equatable.dart';

class DocumentEntity extends Equatable {
  const DocumentEntity({
    required this.id,
    required this.title,
    required this.summary,
    required this.createdAt,
  });

  final int id;
  final String title;
  final String summary;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, title, summary, createdAt];
}
