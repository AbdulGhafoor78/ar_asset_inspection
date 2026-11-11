import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ar_inspection/presentation/screens/ar_inspection_list_screen.dart';
import '../../../assets/presentation/screens/asset_list_screen.dart';
import '../../../dashboard/presentation/providers/dashboard_statistics_provide.dart';
import '../../../inspection/presentation/screens/inspection_list_screen.dart';
import '../../../notifications/presentation/screens/notification_screen.dart';
import '../providers/authentication_notifier.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(dashboardStatisticsProvider.notifier)
          .loadStatistics();
    });
  }

  Future<void> _refreshStatistics() async {
    await ref
        .read(dashboardStatisticsProvider.notifier)
        .loadStatistics();
  }

  Future<void> _openScreen(Widget screen) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );

    if (!mounted) return;

    await _refreshStatistics();
  }

  Future<void> _logout() async {
    await ref
        .read(authenticationProvider.notifier)
        .logout();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final state = ref.watch(dashboardStatisticsProvider);
    final statistics = state.statistics;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: state.isLoading
                ? null
                : _refreshStatistics,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshStatistics,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, Engineer 👋',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Here is your maintenance overview.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Dashboard Statistics',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              if (state.isLoading && statistics == null)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (state.error != null && statistics == null)
                _ErrorMessage(
                  message: state.error!,
                  onRetry: _refreshStatistics,
                )
              else if (statistics != null)
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.25,
                    children: [
                      _DashboardCard(
                        title: 'Total Assets',
                        value: statistics.totalAssets.toString(),
                        icon: Icons.precision_manufacturing,
                      ),
                      _DashboardCard(
                        title: 'Total Inspections',
                        value: statistics.totalInspections.toString(),
                        icon: Icons.assignment_outlined,
                      ),
                      _DashboardCard(
                        title: 'Total Maintenance',
                        value: statistics.totalMaintenance.toString(),
                        icon: Icons.build_outlined,
                      ),
                      _DashboardCard(
                        title: 'Unread Notifications',
                        value: statistics.unreadNotifications.toString(),
                        icon: Icons.notifications_outlined,
                      ),
                    ],
                  ),

              const SizedBox(height: 32),

              Text(
                'Quick Actions',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              _QuickActionButton(
                icon: Icons.precision_manufacturing,
                label: 'View Assets',
                onPressed: () => _openScreen(
                  const AssetListScreen(),
                ),
              ),

              _QuickActionButton(
                icon: Icons.history,
                label: 'Inspection History',
                onPressed: () => _openScreen(
                  const InspectionListScreen(),
                ),
              ),

              _QuickActionButton(
                icon: Icons.notifications_outlined,
                label: 'Notifications',
                onPressed: () => _openScreen(
                  const NotificationScreen(),
                ),
              ),

              _QuickActionButton(
                icon: Icons.view_in_ar,
                label: 'AR Inspections',
                onPressed: () => _openScreen(
                  const ArInspectionListScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 24,
                color: colorScheme.onPrimaryContainer,
              ),
            ),

            const Spacer(),

            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorMessage({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: colorScheme.error,
          ),

          const SizedBox(height: 12),

          Text(
            message,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}