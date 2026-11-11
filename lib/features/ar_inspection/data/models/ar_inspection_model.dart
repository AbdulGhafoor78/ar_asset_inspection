import '../../domain/entities/ar_inspection.dart';

class ArInspectionModel extends ArInspection {
  const ArInspectionModel({
    required super.id,
    required super.assetId,
    required super.assetName,
    required super.assetCode,
    required super.isArAvailable,
    required super.status,
    super.resultSummary,
  });

  factory ArInspectionModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return ArInspectionModel(
      id: json['id'] as int,
      assetId: json['assetId'] as int,
      assetName: json['assetName'] as String,
      assetCode: json['assetCode'] as String,
      isArAvailable: json['isArAvailable'] as bool,
      status: json['status'] as String,
      resultSummary: json['resultSummary'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assetId': assetId,
      'assetName': assetName,
      'assetCode': assetCode,
      'isArAvailable': isArAvailable,
      'status': status,
      'resultSummary': resultSummary,
    };
  }
}