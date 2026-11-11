import '../entities/dashboard_statistics.dart';
import '../repositories/dashboard_statistics_repository.dart';

class GetDashboardStatistics {
  final DashboardStatisticsRepository repository;

  GetDashboardStatistics(this.repository);

  Future<DashboardStatistics> call() {
    return repository.getStatistics();
  }
}