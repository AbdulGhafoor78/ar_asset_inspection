import '../../domain/entities/maintenance_record.dart';

class MaintenanceState {
  final bool isLoading;
  final List<MaintenanceRecord> records;
  final MaintenanceRecord? selectedRecord;
  final MaintenanceRecord? createdRecord;
  final String? error;

  const MaintenanceState({
    this.isLoading = false,
    this.records = const [],
    this.selectedRecord,
    this.createdRecord,
    this.error,
  });

  MaintenanceState copyWith({
    bool? isLoading,
    List<MaintenanceRecord>? records,
    MaintenanceRecord? selectedRecord,
    MaintenanceRecord? createdRecord,
    String? error,
  }) {
    return MaintenanceState(
      isLoading: isLoading ?? this.isLoading,
      records: records ?? this.records,
      selectedRecord: selectedRecord ?? this.selectedRecord,
      createdRecord: createdRecord ?? this.createdRecord,
      error: error ?? this.error,
    );
  }
}