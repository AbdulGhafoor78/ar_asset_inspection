import '../../domain/entities/maintenance_record.dart';

class MaintenanceRecordModel extends MaintenanceRecord {
  const MaintenanceRecordModel({
    required super.id,
    required super.inspectionId,
    required super.issue,
    required super.description,
    required super.priority,
    required super.status,
    required super.createdAt,
    super.completedAt,
  });

  factory MaintenanceRecordModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return MaintenanceRecordModel(
      id: json['id'] as int,
      inspectionId: json['inspectionId'] as int,
      issue: json['issue'] as String,
      description: json['description'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(
        json['createdAt'] as String,
      ),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(
        json['completedAt'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'inspectionId': inspectionId,
      'issue': issue,
      'description': description,
      'priority': priority,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }
}