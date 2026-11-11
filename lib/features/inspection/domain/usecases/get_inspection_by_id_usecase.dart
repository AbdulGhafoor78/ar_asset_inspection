import '../entities/inspection.dart';
import '../repositories/inspection_repository.dart';

class GetInspectionByIdUseCase {
  final InspectionRepository repository;

  GetInspectionByIdUseCase(this.repository);

  Future<Inspection> call(int id) {
    return repository.getInspectionById(id);
  }
}