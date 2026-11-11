import '../entities/inspection_evidence.dart';
import '../repositories/inspection_evidence_repository.dart';

class GetInspectionEvidenceUseCase {
  final InspectionEvidenceRepository repository;

  GetInspectionEvidenceUseCase(this.repository);

  Future<List<InspectionEvidence>> call(
      int inspectionId,
      ) {
    return repository.getEvidence(inspectionId);
  }
}