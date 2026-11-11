import '../../domain/entities/inspection.dart';

class InspectionModel extends Inspection {
  const InspectionModel({
    required super.id,
    required super.assetId,
    required super.engineerId,
    required super.status,
    required super.inspectionDate,
  });

  factory InspectionModel.fromJson(Map<String, dynamic> json) {
    return InspectionModel(
      id: json['id'] as int,
      assetId: json['assetId'] as int,
      engineerId: json['engineerId'] as String,
      status: json['status'] as String,
      inspectionDate: DateTime.parse(
        json['inspectionDate'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assetId': assetId,
      'engineerId': engineerId,
      'status': status,
      'inspectionDate': inspectionDate.toIso8601String(),
    };
  }
}