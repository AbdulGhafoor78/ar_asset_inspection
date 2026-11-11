import '../entities/ar_inspection_result.dart';
import '../repositories/ar_inspection_repository.dart';

class GetArInspectionResults {
  final ArInspectionRepository repository;

  GetArInspectionResults(this.repository);

  Future<List<ArInspectionResult>> call(
      int arInspectionId,
      ) {
    return repository.getInspectionResults(
      arInspectionId,
    );
  }
}