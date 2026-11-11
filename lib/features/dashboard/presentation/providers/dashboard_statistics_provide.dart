
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../assets/presentation/providers/asset_provider.dart'
as asset;
import '../../../inspection/presentation/providers/inspection_provider.dart'
as inspection;
import '../../../maintenance/presentation/providers/maintenance_provider.dart'
as maintenance;
import '../../data/repositories/dashboard_statistics_repository_impl.dart';
import '../../domain/usecases/get_dashboard_statistics.dart';
import 'dashboard_statistics_state.dart';

final dashboardStatisticsRepositoryProvider =
Provider<DashboardStatisticsRepositoryImpl>((ref) {
  return DashboardStatisticsRepositoryImpl(
    assetRepository: ref.read(
      asset.assetRepositoryProvider,
    ),
    inspectionRepository: ref.read(
      inspection.inspectionRepositoryProvider,
    ),
    maintenanceRepository: ref.read(
      maintenance.maintenanceRepositoryProvider,
    ),
  );
});

final getDashboardStatisticsProvider =
Provider<GetDashboardStatistics>((ref) {
  return GetDashboardStatistics(
    ref.read(dashboardStatisticsRepositoryProvider),
  );
});

class DashboardStatisticsNotifier
    extends Notifier<DashboardStatisticsState> {
  @override
  DashboardStatisticsState build() {
    return const DashboardStatisticsState();
  }

  Future<void> loadStatistics() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final statistics = await ref
          .read(getDashboardStatisticsProvider)
          .call();

      state = state.copyWith(
        isLoading: false,
        statistics: statistics,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final dashboardStatisticsProvider =
NotifierProvider<
    DashboardStatisticsNotifier,
    DashboardStatisticsState>(
  DashboardStatisticsNotifier.new,
);
