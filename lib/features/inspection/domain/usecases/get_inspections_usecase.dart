import '../entities/inspection.dart';
import '../repositories/inspection_repository.dart';

class GetInspectionsUseCase {
  final InspectionRepository repository;

  GetInspectionsUseCase(this.repository);

  Future<List<Inspection>> call() {
    return repository.getInspections();
  }
}