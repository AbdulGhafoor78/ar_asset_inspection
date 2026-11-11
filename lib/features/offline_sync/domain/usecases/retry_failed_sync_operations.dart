import '../repositories/sync_repository.dart';

class RetryFailedSyncOperations {
  final SyncRepository repository;

  RetryFailedSyncOperations(this.repository);

  Future<void> call() {
    return repository.retryFailedOperations();
  }
}