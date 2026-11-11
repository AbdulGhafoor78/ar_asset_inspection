
import 'package:drift/drift.dart' as drift;


import '../../../../core/database/app_database.dart' as db;
import '../../domain/entities/inspection_checklist_item.dart' as domain;
import '../../domain/repositories/inspection_checklist_repository.dart';

class InspectionChecklistRepositoryImpl
    implements InspectionChecklistRepository {
  final db.AppDatabase database;

  InspectionChecklistRepositoryImpl(this.database);

  @override
  Future<List<domain.InspectionChecklistItem>> getChecklistItems(
      int inspectionId,
      ) async {
    var query = database.select(database.inspectionChecklistItems)
      ..where((table) => table.inspectionId.equals(inspectionId));

    var rows = await query.get();

    if (rows.isEmpty) {
      const defaultTitles = [
        'Check oil level',
        'Check vibration',
        'Check temperature',
        'Check leakage',
        'Check motor condition',
      ];

      for (final title in defaultTitles) {
        await database
            .into(database.inspectionChecklistItems)
            .insert(
          db.InspectionChecklistItemsCompanion.insert(
            inspectionId: inspectionId,
            title: title,
          ),
        );
      }

      query = database.select(database.inspectionChecklistItems)
        ..where((table) => table.inspectionId.equals(inspectionId));

      rows = await query.get();
    }

    return rows.map(_toDomain).toList();
  }

  @override
  Future<domain.InspectionChecklistItem> updateChecklistItem({
    required int itemId,
    required bool isPassed,
    String? notes,
  }) async {
    final query = database.select(database.inspectionChecklistItems)
      ..where((table) => table.id.equals(itemId));

    final existing = await query.getSingleOrNull();

    if (existing == null) {
      throw Exception('Checklist item not found: $itemId');
    }

    await (database.update(database.inspectionChecklistItems)
      ..where((table) => table.id.equals(itemId)))
        .write(
      db.InspectionChecklistItemsCompanion(
        isPassed: drift.Value(isPassed),
        notes: drift.Value(notes),
      ),
    );

    final updated = await query.getSingleOrNull();

    if (updated == null) {
      throw Exception('Checklist item not found after update: $itemId');
    }

    return _toDomain(updated);
  }

  domain.InspectionChecklistItem _toDomain(
      db.InspectionChecklistItem row,
      ) {
    return domain.InspectionChecklistItem(
      id: row.id,
      inspectionId: row.inspectionId,
      title: row.title,
      isPassed: row.isPassed,
      notes: row.notes,
    );
  }
}
