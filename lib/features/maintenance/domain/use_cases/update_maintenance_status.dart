import '../repositories/maintenance_repository.dart';

class UpdateMaintenanceStatus {
  final MaintenanceRepository repository;

  UpdateMaintenanceStatus(this.repository);

  Future<void> call({
    required int id,
    required String status,
  }) {
    return repository.updateMaintenanceStatus(
      id: id,
      status: status,
    );
  }
}