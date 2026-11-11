import 'package:ar_asset_inspection/features/inspection/domain/repositories/inspection_repository.dart';
import 'package:ar_asset_inspection/features/maintenance/domain/repositories/maintenance_repository.dart';

import '../../../assets/domain/repositories/asset_repository.dart';
import '../models/dashboard_statistics_model.dart';
import '../../domain/entities/dashboard_statistics.dart';
import '../../domain/repositories/dashboard_statistics_repository.dart';

class DashboardStatisticsRepositoryImpl
    implements DashboardStatisticsRepository {

  final AssetRepository assetRepository;
  final InspectionRepository inspectionRepository;
  final MaintenanceRepository maintenanceRepository;

  DashboardStatisticsRepositoryImpl({
    required this.assetRepository,
    required this.inspectionRepository,
    required this.maintenanceRepository,
  });

  @override
  Future<DashboardStatistics> getStatistics() async {
    final assets = await assetRepository.getAssets();
    final inspections = await inspectionRepository.getInspections();
    final maintenanceRecords =
    await maintenanceRepository.getAllMaintenanceRecords();

    return DashboardStatisticsModel(
      totalAssets: assets.length,
      totalInspections: inspections.length,
      totalMaintenance: maintenanceRecords.length,
      unreadNotifications: 2,
    );
  }
}