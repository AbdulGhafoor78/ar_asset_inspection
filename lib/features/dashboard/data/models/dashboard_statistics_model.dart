import '../../domain/entities/dashboard_statistics.dart';

class DashboardStatisticsModel extends DashboardStatistics {
  const DashboardStatisticsModel({
    required super.totalAssets,
    required super.totalInspections,
    required super.totalMaintenance,
    required super.unreadNotifications,
  });

  factory DashboardStatisticsModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return DashboardStatisticsModel(
      totalAssets: json['totalAssets'] as int,
      totalInspections: json['totalInspections'] as int,
      totalMaintenance: json['totalMaintenance'] as int,
      unreadNotifications:
      json['unreadNotifications'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAssets': totalAssets,
      'totalInspections': totalInspections,
      'totalMaintenance': totalMaintenance,
      'unreadNotifications': unreadNotifications,
    };
  }
}