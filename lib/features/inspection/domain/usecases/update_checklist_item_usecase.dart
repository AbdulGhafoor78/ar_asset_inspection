import '../entities/inspection_checklist_item.dart';
import '../repositories/inspection_checklist_repository.dart';

class UpdateChecklistItemUseCase {
  final InspectionChecklistRepository repository;

  UpdateChecklistItemUseCase(this.repository);

  Future<InspectionChecklistItem> call({
    required int itemId,
    required bool isPassed,
    String? notes,
  }) {
    return repository.updateChecklistItem(
      itemId: itemId,
      isPassed: isPassed,
      notes: notes,
    );
  }
}