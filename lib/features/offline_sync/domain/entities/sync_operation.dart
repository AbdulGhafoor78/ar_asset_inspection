
enum SyncStatus {
  pending,
  syncing,
  synced,
  failed,
}

class SyncOperation {
  final int? id;
  final String operationType;
  final String payload;
  final SyncStatus status;
  final DateTime createdAt;
  final int retryCount;
  final String? lastError;

  const SyncOperation({
    this.id,
    required this.operationType,
    required this.payload,
    this.status = SyncStatus.pending,
    required this.createdAt,
    this.retryCount = 0,
    this.lastError,
  });
}
