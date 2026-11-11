class InspectionChecklistItem {
  final int id;
  final int inspectionId;
  final String title;
  final bool isPassed;
  final String? notes;

  const InspectionChecklistItem({
    required this.id,
    required this.inspectionId,
    required this.title,
    this.isPassed = false,
    this.notes,
  });
}