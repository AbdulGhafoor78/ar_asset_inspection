import '../repositories/inspection_evidence_repository.dart';

class DeleteInspectionEvidenceUseCase {
  final InspectionEvidenceRepository repository;

  DeleteInspectionEvidenceUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deleteEvidence(id);
  }
}