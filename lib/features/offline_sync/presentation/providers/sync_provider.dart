
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/inspection/presentation/providers/inspection_provider.dart';
import '../../data/repositories/sync_repository_impl.dart';
import '../../domain/repositories/sync_repository.dart';
import '../../domain/usecases/enqueue_sync_operation.dart';
import '../../domain/usecases/get_pending_sync_operations.dart';
import '../../domain/usecases/get_all_sync_operations.dart';
import '../../domain/usecases/mark_sync_operation_as_synced.dart';
import '../../domain/usecases/mark_sync_operation_as_failed.dart';
import '../../domain/usecases/retry_failed_sync_operations.dart';

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  return SyncRepositoryImpl(ref.watch(appDatabaseProvider));
});

final enqueueSyncOperationProvider =
Provider<EnqueueSyncOperation>((ref) {
  return EnqueueSyncOperation(
    ref.watch(syncRepositoryProvider),
  );
});
final getPendingSyncOperationsProvider =
Provider<GetPendingSyncOperations>((ref) {
  return GetPendingSyncOperations(
    ref.watch(syncRepositoryProvider),
  );
});
final getAllSyncOperationsProvider =
Provider<GetAllSyncOperations>((ref) {
  return GetAllSyncOperations(
    ref.watch(syncRepositoryProvider),
  );
});
final markSyncOperationAsSyncedProvider =
Provider<MarkSyncOperationAsSynced>((ref) {
  return MarkSyncOperationAsSynced(
    ref.watch(syncRepositoryProvider),
  );
});
final markSyncOperationAsFailedProvider =
Provider<MarkSyncOperationAsFailed>((ref) {
  return MarkSyncOperationAsFailed(
    ref.watch(syncRepositoryProvider),
  );
});
final retryFailedSyncOperationsProvider =
Provider<RetryFailedSyncOperations>((ref) {
  return RetryFailedSyncOperations(
    ref.watch(syncRepositoryProvider),
  );
});
