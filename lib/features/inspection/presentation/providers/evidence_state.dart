import '../../domain/entities/inspection_evidence.dart';

class EvidenceState {
  final bool isLoading;
  final List<InspectionEvidence> evidence;
  final String? error;

  const EvidenceState({
    this.isLoading = false,
    this.evidence = const [],
    this.error,
  });

  EvidenceState copyWith({
    bool? isLoading,
    List<InspectionEvidence>? evidence,
    String? error,
  }) {
    return EvidenceState(
      isLoading: isLoading ?? this.isLoading,
      evidence: evidence ?? this.evidence,
      error: error,
    );
  }
}