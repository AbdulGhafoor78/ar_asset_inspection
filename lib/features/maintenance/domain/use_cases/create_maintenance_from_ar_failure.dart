import '../entities/maintenance_record.dart';
import '../repositories/maintenance_repository.dart';

class CreateMaintenanceFromArFailure {
  final MaintenanceRepository repository;

  CreateMaintenanceFromArFailure(this.repository);

  Future<MaintenanceRecord> call({
    required int inspectionId,
    required String issue,
    required String description,
    required String priority,
  }) {
    return repository.createMaintenanceRecord(
      inspectionId: inspectionId,
      issue: issue,
      description: description,
      priority: priority,
    );
  }
}