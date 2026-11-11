import '../entities/maintenance_record.dart';

abstract class MaintenanceRepository {
  Future<List<MaintenanceRecord>> getMaintenanceRecords(
      int inspectionId,
      );

  Future<MaintenanceRecord> createMaintenanceRecord({
    required int inspectionId,
    required String issue,
    required String description,
    required String priority,
  });

  Future<void> updateMaintenanceStatus({
    required int id,
    required String status,
  });

  Future<List<MaintenanceRecord>> getAllMaintenanceRecords();
}