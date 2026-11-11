
import '../entities/inspection_evidence.dart';
import '../repositories/inspection_evidence_repository.dart';

class AddInspectionEvidenceUseCase {
  final InspectionEvidenceRepository repository;

  AddInspectionEvidenceUseCase(this.repository);

  Future<InspectionEvidence> call({
    required int inspectionId,
    required int checklistItemId,
    required String imagePath,
    List<int>? imageBytes,
    String? description,
  }) {
    return repository.addEvidence(
      inspectionId: inspectionId,
      checklistItemId: checklistItemId,
      imagePath: imagePath,
      imageBytes: imageBytes,
      description: description,
    );
  }
}
