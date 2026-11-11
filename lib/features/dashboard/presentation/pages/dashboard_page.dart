import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_statistics_provide.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() =>
      _DashboardPageState();
}

class _DashboardPageState
    extends ConsumerState<DashboardPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(dashboardStatisticsProvider.notifier)
          .loadStatistics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardStatisticsProvider);

    // Loading
    if (state.isLoading && state.statistics == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Engineer Dashboard'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Error
    if (state.error != null && state.statistics == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Engineer Dashboard'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              state.error!,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final statistics = state.statistics;

    // No data
    if (statistics == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Engineer Dashboard'),
        ),
        body: const Center(
          child: Text(
            'No dashboard statistics available.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Engineer Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Welcome
            const Text(
              'Welcome, Engineer 👋',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Here is your maintenance overview.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            // Statistics Cards
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics:
              const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _DashboardCard(
                  title: 'Total Assets',
                  value:
                  statistics.totalAssets.toString(),
                  icon:
                  Icons.precision_manufacturing,
                ),

                _DashboardCard(
                  title: 'Total Inspections',
                  value:
                  statistics.totalInspections.toString(),
                  icon:
                  Icons.assignment_outlined,
                ),

                _DashboardCard(
                  title: 'Total Maintenance',
                  value:
                  statistics.totalMaintenance.toString(),
                  icon:
                  Icons.build_outlined,
                ),

                _DashboardCard(
                  title: 'Unread Notifications',
                  value:
                  statistics.unreadNotifications
                      .toString(),
                  icon:
                  Icons.notifications_outlined,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Daily Productivity
            const Text(
              'Daily Productivity',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              color: Colors.lightBlueAccent,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.trending_up,
                      size: 40,
                    ),

                    const SizedBox(width: 16),

                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '82%',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Today's productivity",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Dashboard Card
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
    return Card(
      color: Colors.lightBlueAccent,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 28,
            ),

            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(title),
          ],
        ),
      ),
    );
  }
}