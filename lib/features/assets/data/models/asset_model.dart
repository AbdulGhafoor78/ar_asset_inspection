import '../../domain/entities/asset.dart';

class AssetModel extends Asset {
  const AssetModel({
    required super.id,
    required super.name,
    required super.assetCode,
    required super.location,
    required super.status,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'] as int,
      name: json['name'] as String,
      assetCode: json['assetCode'] as String,
      location: json['location'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'assetCode': assetCode,
      'location': location,
      'status': status,
    };
  }
}