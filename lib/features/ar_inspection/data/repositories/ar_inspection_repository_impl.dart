
import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/ar_inspection.dart';
import '../../domain/entities/ar_inspection_result.dart';
import '../../domain/repositories/ar_inspection_repository.dart';

class ArInspectionRepositoryImpl implements ArInspectionRepository {
  final AppDatabase database;

  ArInspectionRepositoryImpl(this.database);

  Future<void> _ensureSeeded() async {
    final existing = await database
        .select(database.arInspectionRecords)
        .get();

    if (existing.isNotEmpty) return;

    await database.batch((batch) {
      batch.insertAll(
        database.arInspectionRecords,
        [
          ArInspectionRecordsCompanion.insert(
            assetId: 1,
            assetName: 'Industrial Pump',
            assetCode: 'PUMP-001',
            status: 'Ready',
          ),
          ArInspectionRecordsCompanion.insert(
            assetId: 2,
            assetName: 'Power Generator',
            assetCode: 'GEN-001',
            status: 'Ready',
          ),
          ArInspectionRecordsCompanion.insert(
            assetId: 3,
            assetName: 'HVAC Unit',
            assetCode: 'HVAC-001',
            status: 'Ready',
          ),
        ],
      );
    });
  }

  ArInspection _toInspection(ArInspectionRecord row) {
    return ArInspection(
      id: row.id,
      assetId: row.assetId,
      inspectionId: row.inspectionId,
      assetName: row.assetName,
      assetCode: row.assetCode,
      isArAvailable: row.isArAvailable,
      status: row.status,
      resultSummary: row.resultSummary,
    );
  }

  ArInspectionResult _toResult(ArInspectionResultRecord row) {
    return ArInspectionResult(
      id: row.id,
      arInspectionId: row.arInspectionId,
      inspectionPoint: row.inspectionPoint,
      isPassed: row.isPassed,
    );
  }
  @override
  Future<ArInspection> linkRegularInspection({
    required int arInspectionId,
    required int inspectionId,
  }) async {
    final updated = await (database.update(
      database.arInspectionRecords,
    )..where((item) => item.id.equals(arInspectionId)))
        .write(
      ArInspectionRecordsCompanion(
        inspectionId: Value(inspectionId),
      ),
    );

    if (updated == 0) {
      throw Exception('AR inspection not found');
    }

    return getArInspectionById(arInspectionId);
  }

  @override
  Future<List<ArInspection>> getArInspections() async {
    await _ensureSeeded();

    final rows = await database
        .select(database.arInspectionRecords)
        .get();

    return rows.map(_toInspection).toList();
  }

  @override
  Future<ArInspection> getArInspectionById(int id) async {
    await _ensureSeeded();

    final row = await (database
        .select(database.arInspectionRecords)
      ..where((item) => item.id.equals(id)))
        .getSingleOrNull();

    if (row == null) {
      throw Exception('AR inspection not found');
    }

    return _toInspection(row);
  }

  @override
  Future<ArInspection> startArInspection(int id) async {
    await _ensureSeeded();

    final updated = await (database
        .update(database.arInspectionRecords)
      ..where((item) => item.id.equals(id)))
        .write(
      const ArInspectionRecordsCompanion(
        status: Value('In Progress'),
      ),
    );

    if (updated == 0) {
      throw Exception('AR inspection not found');
    }

    return getArInspectionById(id);
  }

  @override
  Future<ArInspection> completeArInspection(int id) async {
    await _ensureSeeded();


    final results = await getInspectionResults(id);

    final hasFailedResult = results.any((result) => !result.isPassed);

    final summary = hasFailedResult
        ? 'Requires Attention'
        : 'Passed';

    final updated = await (database
        .update(database.arInspectionRecords)
      ..where((item) => item.id.equals(id)))
        .write(
      ArInspectionRecordsCompanion(
        status: const Value('Completed'),
        resultSummary: Value(summary),
      ),
    );

    if (updated == 0) {
      throw Exception('AR inspection not found');
    }

    //return inspection.copyWithNotAvailable();
    return getArInspectionById(id);
  }

  @override
  Future<ArInspectionResult> saveInspectionResult(
      int arInspectionId,
      String inspectionPoint,
      bool isPassed,
      ) async {
    await _ensureSeeded();

    final inspection = await (database
        .select(database.arInspectionRecords)
      ..where((item) => item.id.equals(arInspectionId)))
        .getSingleOrNull();

    if (inspection == null) {
      throw Exception('AR inspection not found');
    }

    final id = await database
        .into(database.arInspectionResultRecords)
        .insert(
      ArInspectionResultRecordsCompanion.insert(
        arInspectionId: arInspectionId,
        inspectionPoint: inspectionPoint,
        isPassed: isPassed,
      ),
    );

    final row = await (database
        .select(database.arInspectionResultRecords)
      ..where((item) => item.id.equals(id)))
        .getSingle();

    return _toResult(row);
  }

  @override
  Future<List<ArInspectionResult>> getInspectionResults(
      int arInspectionId,
      ) async {
    final rows = await (database
        .select(database.arInspectionResultRecords)
      ..where((item) => item.arInspectionId.equals(arInspectionId)))
        .get();

    return rows.map(_toResult).toList();
  }
}
