
class InspectionEvidence {
  final int id;
  final int inspectionId;
  final int checklistItemId;
  final String imagePath;
  final List<int>? imageBytes;
  final String? description;
  final DateTime createdAt;

  const InspectionEvidence({
    required this.id,
    required this.inspectionId,
    required this.checklistItemId,
    required this.imagePath,
    this.imageBytes,
    this.description,
    required this.createdAt,
  });
}
