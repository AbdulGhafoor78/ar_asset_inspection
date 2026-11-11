import '../../domain/entities/inspection_checklist_item.dart';

class ChecklistState {
  final bool isLoading;
  final List<InspectionChecklistItem> items;
  final String? error;

  const ChecklistState({
    this.isLoading = false,
    this.items = const [],
    this.error,
  });

  ChecklistState copyWith({
    bool? isLoading,
    List<InspectionChecklistItem>? items,
    String? error,
  }) {
    return ChecklistState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      error: error,
    );
  }
}