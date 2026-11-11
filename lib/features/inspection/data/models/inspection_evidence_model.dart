import '../../domain/entities/inspection_evidence.dart';

class InspectionEvidenceModel extends InspectionEvidence {
  const InspectionEvidenceModel({
    required super.id,
    required super.inspectionId,
    required super.checklistItemId,
    required super.imagePath,
    super.description,
    required super.createdAt,
  });

  factory InspectionEvidenceModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return InspectionEvidenceModel(
      id: json['id'] as int,
      inspectionId: json['inspectionId'] as int,
      checklistItemId: json['checklistItemId'] as int,
      imagePath: json['imagePath'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(
        json['createdAt'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'inspectionId': inspectionId,
      'checklistItemId': checklistItemId,
      'imagePath': imagePath,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}