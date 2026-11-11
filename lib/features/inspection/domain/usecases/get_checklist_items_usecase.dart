import '../entities/inspection_checklist_item.dart';
import '../repositories/inspection_checklist_repository.dart';

class GetChecklistItemsUseCase {
  final InspectionChecklistRepository repository;

  GetChecklistItemsUseCase(this.repository);

  Future<List<InspectionChecklistItem>> call(
      int inspectionId,
      ) {
    return repository.getChecklistItems(inspectionId);
  }
}