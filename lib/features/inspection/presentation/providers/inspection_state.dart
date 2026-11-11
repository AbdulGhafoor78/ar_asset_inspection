import '../../domain/entities/inspection.dart';

class InspectionState {
  final bool isLoading;
  final List<Inspection> inspections;
  final Inspection? selectedInspection;
  final Inspection? createdInspection;
  final String? error;

  const InspectionState({
    this.isLoading = false,
    this.inspections = const [],
    this.selectedInspection,
    this.createdInspection,
    this.error,
  });

  InspectionState copyWith({
    bool? isLoading,
    List<Inspection>? inspections,
    Inspection? selectedInspection,
    Inspection? createdInspection,
    String? error,
    bool clearSelectedInspection = false,
    bool clearCreatedInspection = false,
    bool clearError = false,
  }) {
    return InspectionState(
      isLoading: isLoading ?? this.isLoading,
      inspections: inspections ?? this.inspections,
      selectedInspection: clearSelectedInspection
          ? null
          : selectedInspection ?? this.selectedInspection,
      createdInspection: clearCreatedInspection
          ? null
          : createdInspection ?? this.createdInspection,
      error: clearError ? null : error ?? this.error,
    );
  }
}