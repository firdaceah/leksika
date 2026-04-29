import 'package:equatable/equatable.dart';
import 'package:leksika/features/summary/domain/entities/document_entity.dart';

abstract class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object?> get props => [];
}

class SummaryInitial extends SummaryState {
  const SummaryInitial();
}

class SummaryLoading extends SummaryState {
  const SummaryLoading();
}

class SummaryListLoaded extends SummaryState {
  const SummaryListLoaded(this.documents);

  final List<DocumentEntity> documents;

  @override
  List<Object?> get props => [documents];
}

class SummaryDetailLoaded extends SummaryState {
  const SummaryDetailLoaded(this.document);

  final DocumentEntity document;

  @override
  List<Object?> get props => [document];
}

class SummaryFailure extends SummaryState {
  const SummaryFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
