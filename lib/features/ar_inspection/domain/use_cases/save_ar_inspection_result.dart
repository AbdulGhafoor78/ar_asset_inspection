import '../entities/ar_inspection_result.dart';
import '../repositories/ar_inspection_repository.dart';

class SaveArInspectionResult {
  final ArInspectionRepository repository;

  SaveArInspectionResult(this.repository);

  Future<ArInspectionResult> call(
      int arInspectionId,
      String inspectionPoint,
      bool isPassed,
      ) {
    return repository.saveInspectionResult(
      arInspectionId,
      inspectionPoint,
      isPassed,
    );
  }
}