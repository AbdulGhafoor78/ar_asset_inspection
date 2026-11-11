import '../../domain/entities/dashboard_statistics.dart';

class DashboardStatisticsState {
  final bool isLoading;
  final DashboardStatistics? statistics;
  final String? error;

  const DashboardStatisticsState({
    this.isLoading = false,
    this.statistics,
    this.error,
  });

  DashboardStatisticsState copyWith({
    bool? isLoading,
    DashboardStatistics? statistics,
    String? error,
  }) {
    return DashboardStatisticsState(
      isLoading: isLoading ?? this.isLoading,
      statistics: statistics ?? this.statistics,
      error: error ?? this.error,
    );
  }
}