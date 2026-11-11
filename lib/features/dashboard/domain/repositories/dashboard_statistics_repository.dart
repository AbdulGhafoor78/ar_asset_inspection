import '../entities/dashboard_statistics.dart';

abstract class DashboardStatisticsRepository {
  Future<DashboardStatistics> getStatistics();
}