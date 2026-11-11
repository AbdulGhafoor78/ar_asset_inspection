import '../repositories/sync_repository.dart';

class MarkSyncOperationAsSynced {
  final SyncRepository repository;

  MarkSyncOperationAsSynced(this.repository);

  Future<void> call(int id) {
    return repository.markAsSynced(id);
  }
}