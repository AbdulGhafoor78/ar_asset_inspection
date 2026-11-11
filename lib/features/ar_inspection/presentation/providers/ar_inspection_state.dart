import '../../domain/entities/ar_inspection.dart';
import '../../domain/entities/ar_inspection_result.dart';

class ArInspectionState {
  final bool isLoading;
  final List<ArInspection> inspections;
  final ArInspection? selectedInspection;
  final ArInspection? startedInspection;
  final List<ArInspectionResult> inspectionResults;
  final String? error;

  const ArInspectionState({
    this.isLoading = false,
    this.inspections = const [],
    this.selectedInspection,
    this.startedInspection,
    this.inspectionResults = const [],
    this.error,
  });

  ArInspectionState copyWith({
    bool? isLoading,
    List<ArInspection>? inspections,
    ArInspection? selectedInspection,
    ArInspection? startedInspection,
    List<ArInspectionResult>? inspectionResults,
    String? error,
  }) {
    return ArInspectionState(
      isLoading: isLoading ?? this.isLoading,
      inspections: inspections ?? this.inspections,
      selectedInspection:
      selectedInspection ?? this.selectedInspection,
      startedInspection:
      startedInspection ?? this.startedInspection,
      inspectionResults:
      inspectionResults ?? this.inspectionResults,
      error: error ?? this.error,
    );
  }
}