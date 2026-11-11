import '../../domain/entities/inspection_checklist_item.dart';

class InspectionChecklistItemModel
    extends InspectionChecklistItem {
  const InspectionChecklistItemModel({
    required super.id,
    required super.inspectionId,
    required super.title,
    super.isPassed,
    super.notes,
  });

  factory InspectionChecklistItemModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return InspectionChecklistItemModel(
      id: json['id'] as int,
      inspectionId: json['inspectionId'] as int,
      title: json['title'] as String,
      isPassed: json['isPassed'] as bool,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'inspectionId': inspectionId,
      'title': title,
      'isPassed': isPassed,
      'notes': notes,
    };
  }
}