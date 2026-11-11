import '../entities/sync_operation.dart';
import '../repositories/sync_repository.dart';

class GetAllSyncOperations {
  final SyncRepository repository;

  GetAllSyncOperations(this.repository);

  Future<List<SyncOperation>> call() {
    return repository.getAllOperations();
  }
}