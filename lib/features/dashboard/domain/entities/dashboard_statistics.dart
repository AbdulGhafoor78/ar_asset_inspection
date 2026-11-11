class DashboardStatistics {
  final int totalAssets;
  final int totalInspections;
  final int totalMaintenance;
  final int unreadNotifications;

  const DashboardStatistics({
    required this.totalAssets,
    required this.totalInspections,
    required this.totalMaintenance,
    required this.unreadNotifications,
  });
}