import '../entities/inspection.dart';
import '../repositories/inspection_repository.dart';

class CompleteInspectionUseCase {
  final InspectionRepository repository;

  CompleteInspectionUseCase(this.repository);

  Future<Inspection> call(int id) {
    return repository.completeInspection(id);
  }
}