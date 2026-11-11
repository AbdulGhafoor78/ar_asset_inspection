


import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/inspection_evidence.dart';
import '../../domain/repositories/inspection_evidence_repository.dart';

class InspectionEvidenceRepositoryImpl
    implements InspectionEvidenceRepository {
  final AppDatabase database;

  InspectionEvidenceRepositoryImpl(this.database);

  @override
  Future<List<InspectionEvidence>> getEvidence(
      int inspectionId,
      ) async {
    final query = database.select(
      database.inspectionEvidenceRecords,
    )..where((row) => row.inspectionId.equals(inspectionId));

    final rows = await query.get();

    return rows.map(_toEntity).toList();
  }

  @override
  Future<InspectionEvidence> addEvidence({
    required int inspectionId,
    required int checklistItemId,
    required String imagePath,
    List<int>? imageBytes,
    String? description,
  }) async {
    final createdAt = DateTime.now();

    final id = await database.into(
      database.inspectionEvidenceRecords,
    ).insert(
      InspectionEvidenceRecordsCompanion.insert(
        inspectionId: inspectionId,
        checklistItemId: checklistItemId,
        imagePath: imagePath,
        imageBytes: Value(
          imageBytes == null
              ? null
              : Uint8List.fromList(imageBytes),
        ),
        description: Value(description),
        createdAt: createdAt,
      ),
    );

    final row = await (database.select(
      database.inspectionEvidenceRecords,
    )..where((item) => item.id.equals(id)))
        .getSingle();

    return _toEntity(row);
  }

  @override
  Future<void> deleteEvidence(int id) async {
    final deleted = await (database.delete(
      database.inspectionEvidenceRecords,
    )..where((row) => row.id.equals(id)))
        .go();

    if (deleted == 0) {
      throw Exception('Evidence not found');
    }
  }

  InspectionEvidence _toEntity(InspectionEvidenceRecord row) {
    return InspectionEvidence(
      id: row.id,
      inspectionId: row.inspectionId,
      checklistItemId: row.checklistItemId,
      imagePath: row.imagePath,
      imageBytes: row.imageBytes,
      description: row.description,
      createdAt: row.createdAt,
    );
  }
}
