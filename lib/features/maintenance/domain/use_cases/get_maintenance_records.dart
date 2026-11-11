import '../entities/maintenance_record.dart';
import '../repositories/maintenance_repository.dart';

class GetMaintenanceRecords {
  final MaintenanceRepository repository;

  GetMaintenanceRecords(this.repository);

  Future<List<MaintenanceRecord>> call(
      int inspectionId,
      ) {
    return repository.getMaintenanceRecords(inspectionId);
  }
}