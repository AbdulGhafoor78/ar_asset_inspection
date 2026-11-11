import '../entities/ar_inspection.dart';
import '../repositories/ar_inspection_repository.dart';

class GetArInspections {
  final ArInspectionRepository repository;

  GetArInspections(this.repository);

  Future<List<ArInspection>> call() {
    return repository.getArInspections();
  }
}