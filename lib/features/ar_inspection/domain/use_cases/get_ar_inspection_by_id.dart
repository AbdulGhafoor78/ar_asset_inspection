import '../entities/ar_inspection.dart';
import '../repositories/ar_inspection_repository.dart';

class GetArInspectionById {
  final ArInspectionRepository repository;

  GetArInspectionById(this.repository);

  Future<ArInspection> call(int id) {
    return repository.getArInspectionById(id);
  }
}