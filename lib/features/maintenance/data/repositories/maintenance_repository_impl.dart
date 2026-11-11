
import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart'   hide MaintenanceRecord;
import '../../domain/entities/maintenance_record.dart';

import '../../../../core/database/app_database.dart' as db;
import '../../domain/entities/maintenance_record.dart' as domain;

import '../../domain/repositories/maintenance_repository.dart';

class MaintenanceRepositoryImpl implements MaintenanceRepository {
  final AppDatabase database;

  MaintenanceRepositoryImpl(this.database);


  domain.MaintenanceRecord _toEntity(db.MaintenanceRecord row) {
    return domain.MaintenanceRecord(
      id: row.id,
      inspectionId: row.inspectionId,
      issue: row.issue,
      description: row.description,
      priority: row.priority,
      status: row.status,
      createdAt: row.createdAt,
      completedAt: row.completedAt,
    );
  }

  @override
  Future<List<MaintenanceRecord>> getMaintenanceRecords(
      int inspectionId,
      ) async {
    final query = database.select(database.maintenanceRecords)
      ..where((record) => record.inspectionId.equals(inspectionId));

    final rows = await query.get();

    return rows.map<MaintenanceRecord>(_toEntity).toList();
  }

  @override
  Future<List<MaintenanceRecord>> getAllMaintenanceRecords() async {
    final rows = await database.select(database.maintenanceRecords).get();

    return rows.map<MaintenanceRecord>(_toEntity).toList();
  }

  @override
  Future<MaintenanceRecord> createMaintenanceRecord({
    required int inspectionId,
    required String issue,
    required String description,
    required String priority,
  }) async {
    final now = DateTime.now();

    final id = await database.into(database.maintenanceRecords).insert(
      MaintenanceRecordsCompanion.insert(
        inspectionId: inspectionId,
        issue: issue,
        description: description,
        priority: priority,
        status: 'Pending',
        createdAt: now,
      ),
    );

    final row = await (database.select(database.maintenanceRecords)
      ..where((record) => record.id.equals(id)))
        .getSingle();

    return _toEntity(row);
  }

  @override
  Future<void> updateMaintenanceStatus({
    required int id,
    required String status,
  }) async {
    final query = database.select(database.maintenanceRecords)
      ..where((record) => record.id.equals(id));

    final existing = await query.getSingleOrNull();

    if (existing == null) {
      throw Exception('Maintenance record not found');
    }

    final completedAt = status == 'Completed'
        ? (existing.completedAt ?? DateTime.now())
        : existing.completedAt;

    await (database.update(database.maintenanceRecords)
      ..where((record) => record.id.equals(id)))
        .write(
      MaintenanceRecordsCompanion(
        status: Value(status),
        completedAt: Value(completedAt),
      ),
    );
  }
}
