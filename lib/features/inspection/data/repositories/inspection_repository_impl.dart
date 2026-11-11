
import 'package:drift/drift.dart' as drift;


import '../../../../core/database/app_database.dart' as db;
import '../../domain/entities/inspection.dart' as domain;
import '../../domain/repositories/inspection_repository.dart';

class InspectionRepositoryImpl implements InspectionRepository {
  final db.AppDatabase database;

  InspectionRepositoryImpl(this.database);

  @override
  Future<List<domain.Inspection>> getInspections() async {
    final rows = await database.select(database.inspections).get();

    return rows.map(_toDomain).toList();
  }

  @override
  Future<domain.Inspection> getInspectionById(int id) async {
    final query = database.select(database.inspections)
      ..where((table) => table.id.equals(id));

    final row = await query.getSingleOrNull();

    if (row == null) {
      throw Exception('Inspection not found: $id');
    }

    return _toDomain(row);
  }

  @override
  Future<domain.Inspection> createInspection({
    required int assetId,
    required String engineerId,
  }) async {
    final now = DateTime.now();

    final id = await database.into(database.inspections).insert(
      db.InspectionsCompanion.insert(
        assetId: assetId,
        engineerId: engineerId,
        status: 'In Progress',
        inspectionDate: now,
      ),
    );

    return getInspectionById(id);
  }

  @override
  Future<domain.Inspection> completeInspection(int id) async {
    final query = database.select(database.inspections)
      ..where((table) => table.id.equals(id));

    final existing = await query.getSingleOrNull();

    if (existing == null) {
      throw Exception('Inspection not found: $id');
    }

    await (database.update(database.inspections)
      ..where((table) => table.id.equals(id)))
        .write(
      const db.InspectionsCompanion(
        status: drift.Value('Completed'),
      ),
    );

    return getInspectionById(id);
  }

  domain.Inspection _toDomain(db.Inspection row) {
    return domain.Inspection(
      id: row.id,
      assetId: row.assetId,
      engineerId: row.engineerId,
      status: row.status,
      inspectionDate: row.inspectionDate,
    );
  }
}