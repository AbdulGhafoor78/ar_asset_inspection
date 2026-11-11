import '../entities/inspection_checklist_item.dart';

abstract class InspectionChecklistRepository {
  Future<List<InspectionChecklistItem>> getChecklistItems(
      int inspectionId,
      );

  Future<InspectionChecklistItem> updateChecklistItem({
    required int itemId,
    required bool isPassed,
    String? notes,
  });
}