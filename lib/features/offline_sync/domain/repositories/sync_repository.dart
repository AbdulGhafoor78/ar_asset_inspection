
import '../entities/sync_operation.dart';

abstract class SyncRepository {
  Future<int> enqueue(SyncOperation operation);

  Future<List<SyncOperation>> getPendingOperations();

  Future<List<SyncOperation>> getAllOperations();

  Future<void> markAsSyncing(int id);

  Future<void> markAsSynced(int id);

  Future<void> markAsFailed(int id, String error);

  Future<void> retryFailedOperations();
}
