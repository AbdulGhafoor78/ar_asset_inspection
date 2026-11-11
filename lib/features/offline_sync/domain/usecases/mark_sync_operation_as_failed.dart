import '../repositories/sync_repository.dart';

class MarkSyncOperationAsFailed {
  final SyncRepository repository;

  MarkSyncOperationAsFailed(this.repository);

  Future<void> call({
    required int id,
    required String error,
  }) {
    return repository.markAsFailed(id, error);
  }
}