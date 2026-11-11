
import 'package:flutter_test/flutter_test.dart';
import 'package:ar_asset_inspection/features/offline_sync/data/repositories/sync_repository_impl.dart';
import 'package:ar_asset_inspection/features/offline_sync/domain/entities/sync_operation.dart';


import '../../support/test_app_database.dart';

void main() {
  late TestAppDatabase database;
  late SyncRepositoryImpl repository;

  setUp(() {
    database = TestAppDatabase();
    repository = SyncRepositoryImpl(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('enqueue saves an operation as pending', () async {
    final operation = SyncOperation(
      operationType: 'inspection',
      payload: '{"inspectionId":1}',
      createdAt: DateTime(2026, 10, 25),
    );

    final id = await repository.enqueue(operation);
    final pending = await repository.getPendingOperations();

    expect(id, greaterThan(0));
    expect(pending, hasLength(1));
    expect(pending.first.operationType, 'inspection');
    expect(pending.first.status, SyncStatus.pending);
  });

  test('failed operation can be retried', () async {
    final operation = SyncOperation(
      operationType: 'inspection',
      payload: '{"inspectionId":2}',
      createdAt: DateTime(2026, 10, 25),
    );

    final id = await repository.enqueue(operation);

    await repository.markAsFailed(id, 'Network unavailable');

    var allOperations = await repository.getAllOperations();
    expect(allOperations.first.status, SyncStatus.failed);
    expect(allOperations.first.retryCount, 1);
    expect(allOperations.first.lastError, 'Network unavailable');

    await repository.retryFailedOperations();

    final pending = await repository.getPendingOperations();
    expect(pending, hasLength(1));
    expect(pending.first.id, id);
    expect(pending.first.status, SyncStatus.pending);
    expect(pending.first.lastError, isNull);
  });

}
