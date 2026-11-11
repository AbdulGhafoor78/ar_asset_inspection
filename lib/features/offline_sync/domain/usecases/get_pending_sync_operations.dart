import '../entities/sync_operation.dart';
import '../repositories/sync_repository.dart';

class GetPendingSyncOperations {
  final SyncRepository repository;

  GetPendingSyncOperations(this.repository);

  Future<List<SyncOperation>> call() {
    return repository.getPendingOperations();
  }
}