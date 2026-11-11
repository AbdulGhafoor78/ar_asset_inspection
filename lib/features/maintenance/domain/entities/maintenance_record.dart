class MaintenanceRecord {
  final int id;
  final int inspectionId;
  final String issue;
  final String description;
  final String priority;
  final String status;
  final DateTime createdAt;
  final DateTime? completedAt;

  const MaintenanceRecord({
    required this.id,
    required this.inspectionId,
    required this.issue,
    required this.description,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.completedAt,
  });
}