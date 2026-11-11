import '../entities/ar_inspection.dart';
import '../repositories/ar_inspection_repository.dart';

class CompleteArInspection {
  final ArInspectionRepository repository;

  CompleteArInspection(this.repository);

  Future<ArInspection> call(int id) {
    return repository.completeArInspection(id);
  }
}