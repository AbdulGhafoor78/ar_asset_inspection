
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';

part 'app_database.g.dart';
//flutter run -d chrome --web-port=51789

class Inspections extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get assetId => integer()();

  TextColumn get engineerId => text()();

  TextColumn get status => text()();

  DateTimeColumn get inspectionDate => dateTime()();
}

class InspectionChecklistItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get inspectionId => integer()();

  TextColumn get title => text()();

  BoolColumn get isPassed =>
      boolean().withDefault(const Constant(false))();

  TextColumn get notes => text().nullable()();
}

class InspectionEvidenceRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get inspectionId => integer()();
  IntColumn get checklistItemId => integer()();
  TextColumn get imagePath => text()();
  BlobColumn get imageBytes => blob().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}
class ArInspectionRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get inspectionId => integer().nullable()();

  IntColumn get assetId => integer()();

  TextColumn get assetName => text()();

  TextColumn get assetCode => text()();

  BoolColumn get isArAvailable =>
      boolean().withDefault(const Constant(true))();

  TextColumn get status => text()();

  TextColumn get resultSummary => text().nullable()();

}

class ArInspectionResultRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get arInspectionId => integer()();

  TextColumn get inspectionPoint => text()();

  BoolColumn get isPassed => boolean()();
}

class MaintenanceRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get inspectionId => integer()();

  TextColumn get issue => text()();

  TextColumn get description => text()();

  TextColumn get priority => text()();

  TextColumn get status => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get completedAt => dateTime().nullable()();
}

class SyncOperations extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get operationType => text()();

  TextColumn get payload => text()();

  TextColumn get status =>
      text().withDefault(const Constant('pending'))();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get retryCount =>
      integer().withDefault(const Constant(0))();

  TextColumn get lastError => text().nullable()();
}

@DriftDatabase(
  tables: [
    Inspections,
    InspectionChecklistItems,
    InspectionEvidenceRecords,
    ArInspectionRecords,
    ArInspectionResultRecords,
    MaintenanceRecords,
    SyncOperations,
  ],
)
class AppDatabase extends _$AppDatabase {

  AppDatabase()
      : super(
    driftDatabase(
      name: 'ar_asset_inspection',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
        onResult: (result) {
          debugPrint(
            'Drift web database storage: '
                '${result.chosenImplementation}',
          );
          debugPrint(
            'Missing browser features: '
                '${result.missingFeatures}',
          );
        },
      ),
    ),
  );

  AppDatabase.forTesting(super.executor);


  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(inspectionChecklistItems);
      }

      if (from < 3) {
        await m.createTable(inspectionEvidenceRecords);
      }
      if (from < 4) {
        await m.createTable(arInspectionRecords);
        await m.createTable(arInspectionResultRecords);
      }
      if (from < 5) {
        await m.createTable(maintenanceRecords);
      }
      if (from < 6) {
        await m.addColumn(
          arInspectionRecords,
          arInspectionRecords.inspectionId,
        );
      }
      if (from < 7) {
        await m.createTable(syncOperations);
      }
    },
  );
}

