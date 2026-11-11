
import '../entities/inspection_evidence.dart';

abstract class InspectionEvidenceRepository {
  Future<List<InspectionEvidence>> getEvidence(int inspectionId);

  Future<InspectionEvidence> addEvidence({
    required int inspectionId,
    required int checklistItemId,
    required String imagePath,
    List<int>? imageBytes,
    String? description,
  });

  Future<void> deleteEvidence(int id);
}
