import '../entities/sync_operation.dart';
import '../repositories/sync_repository.dart';

class EnqueueSyncOperation {
  final SyncRepository repository;

  EnqueueSyncOperation(this.repository);

  Future<int> call(SyncOperation operation) {
    return repository.enqueue(operation);
  }
}