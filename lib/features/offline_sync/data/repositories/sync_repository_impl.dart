
import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart' as db;
import '../../domain/entities/sync_operation.dart' as domain;
import '../../domain/repositories/sync_repository.dart';

class SyncRepositoryImpl implements SyncRepository {
  final db.AppDatabase database;

  SyncRepositoryImpl(this.database);

  domain.SyncOperation _toEntity(db.SyncOperation row) {
    return domain.SyncOperation(
      id: row.id,
      operationType: row.operationType,
      payload: row.payload,
      status: domain.SyncStatus.values.firstWhere(
            (status) => status.name == row.status,
        orElse: () => domain.SyncStatus.pending,
      ),
      createdAt: row.createdAt,
      retryCount: row.retryCount,
      lastError: row.lastError,
    );
  }

  @override
  Future<int> enqueue(domain.SyncOperation operation) async {
    return database.into(database.syncOperations).insert(
      db.SyncOperationsCompanion.insert(
        operationType: operation.operationType,
        payload: operation.payload,
        status: Value(operation.status.name),
        createdAt: operation.createdAt,
        retryCount: Value(operation.retryCount),
        lastError: Value(operation.lastError),
      ),
    );
  }

  @override
  Future<List<domain.SyncOperation>> getPendingOperations() async {
    final rows = await (database.select(database.syncOperations)
      ..where(
            (row) => row.status.equals(domain.SyncStatus.pending.name),
      )
      ..orderBy([
            (row) => OrderingTerm.asc(row.createdAt),
      ]))
        .get();

    return rows.map(_toEntity).toList();
  }

  @override
  Future<List<domain.SyncOperation>> getAllOperations() async {
    final rows = await (database.select(database.syncOperations)
      ..orderBy([
            (row) => OrderingTerm.desc(row.createdAt),
      ]))
        .get();

    return rows.map(_toEntity).toList();
  }

  @override
  Future<void> markAsSyncing(int id) async {
    await _updateStatus(id, domain.SyncStatus.syncing);
  }

  @override
  Future<void> markAsSynced(int id) async {
    await _updateStatus(id, domain.SyncStatus.synced);
  }

  @override
  Future<void> markAsFailed(int id, String error) async {
    final existing = await (database.select(database.syncOperations)
      ..where((row) => row.id.equals(id)))
        .getSingleOrNull();

    if (existing == null) {
      throw Exception('Sync operation not found: $id');
    }

    await (database.update(database.syncOperations)
      ..where((row) => row.id.equals(id)))
        .write(
      db.SyncOperationsCompanion(
        status: Value(domain.SyncStatus.failed.name),
        retryCount: Value(existing.retryCount + 1),
        lastError: Value(error),
      ),
    );
  }

  Future<void> _updateStatus(
      int id,
      domain.SyncStatus status,
      ) async {
    await (database.update(database.syncOperations)
      ..where((row) => row.id.equals(id)))
        .write(
      db.SyncOperationsCompanion(
        status: Value(status.name),
        lastError: const Value(null),
      ),
    );
  }

  @override
  Future<void> retryFailedOperations() async {
    await (database.update(database.syncOperations)
      ..where(
            (row) => row.status.equals(domain.SyncStatus.failed.name),
      ))
        .write(
      const db.SyncOperationsCompanion(
        status: Value('pending'),
        lastError: Value(null),
      ),
    );
  }
}

