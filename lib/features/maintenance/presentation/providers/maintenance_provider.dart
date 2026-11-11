import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../inspection/presentation/providers/inspection_provider.dart';
import '../../domain/repositories/maintenance_repository.dart';

import '../../data/repositories/maintenance_repository_impl.dart';
import '../../domain/entities/maintenance_record.dart';
import '../../domain/use_cases/create_maintenance_from_ar_failure.dart';
import '../../domain/use_cases/create_maintenance_record.dart';
import '../../domain/use_cases/get_maintenance_records.dart';
import '../../domain/use_cases/update_maintenance_status.dart';
import 'maintenance_state.dart';

final maintenanceRepositoryProvider =
Provider<MaintenanceRepository>((ref) {
  return MaintenanceRepositoryImpl(
    ref.read(appDatabaseProvider),
  );
});

final getMaintenanceRecordsProvider =
Provider<GetMaintenanceRecords>((ref) {
  return GetMaintenanceRecords(
    ref.read(maintenanceRepositoryProvider),
  );
});

final createMaintenanceRecordProvider =
Provider<CreateMaintenanceRecord>((ref) {
  return CreateMaintenanceRecord(
    ref.read(maintenanceRepositoryProvider),
  );
});
final createMaintenanceFromArFailureProvider =
Provider<CreateMaintenanceFromArFailure>((ref) {
  return CreateMaintenanceFromArFailure(
    ref.read(maintenanceRepositoryProvider),
  );
});

final updateMaintenanceStatusProvider =
Provider<UpdateMaintenanceStatus>((ref) {
  return UpdateMaintenanceStatus(
    ref.read(maintenanceRepositoryProvider),
  );
});

class MaintenanceNotifier extends Notifier<MaintenanceState> {
  @override
  MaintenanceState build() {
    return const MaintenanceState();
  }

  Future<void> loadMaintenanceRecords(int inspectionId) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final records = await ref
          .read(getMaintenanceRecordsProvider)
          .call(inspectionId);

      state = state.copyWith(
        isLoading: false,
        records: records,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> createRecord({
    required int inspectionId,
    required String issue,
    required String description,
    required String priority,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final record = await ref
          .read(createMaintenanceRecordProvider)
          .call(
        inspectionId: inspectionId,
        issue: issue,
        description: description,
        priority: priority,
      );

      state = state.copyWith(
        isLoading: false,
        createdRecord: record,
      );

      await loadMaintenanceRecords(inspectionId);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
  Future<MaintenanceRecord?> createFromArFailure({
    required int inspectionId,
    required String issue,
    required String description,
    required String priority,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final record = await ref
          .read(createMaintenanceFromArFailureProvider)
          .call(
        inspectionId: inspectionId,
        issue: issue,
        description: description,
        priority: priority,
      );

      state = state.copyWith(
        isLoading: false,
      );

      return record;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );

      return null;
    }
  }


  Future<void> updateStatus({
    required int id,
    required String status,
    required int inspectionId,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      await ref
          .read(updateMaintenanceStatusProvider)
          .call(
        id: id,
        status: status,
      );

      await loadMaintenanceRecords(inspectionId);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final maintenanceProvider =
NotifierProvider<MaintenanceNotifier, MaintenanceState>(
  MaintenanceNotifier.new,
);