import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/ar_inspection_provider.dart';
import '../providers/ar_inspection_state.dart';
import 'ar_inspection_detail_screen.dart';

class ArInspectionListScreen extends ConsumerStatefulWidget {
  const ArInspectionListScreen({super.key});

  @override
  ConsumerState<ArInspectionListScreen> createState() =>
      _ArInspectionListScreenState();
}

class _ArInspectionListScreenState
    extends ConsumerState<ArInspectionListScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(arInspectionProvider.notifier)
          .loadArInspections();
    });
  }

  Future<void> _refreshInspections() async {
    await ref
        .read(arInspectionProvider.notifier)
        .loadArInspections();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(arInspectionProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172B4D),

        title: const Text(
          'AR Inspections',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: _refreshInspections,
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh',
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: _refreshInspections,
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(ArInspectionState state) {
    if (state.isLoading && state.inspections.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.error != null && state.inspections.isEmpty) {
      return _ErrorState(
        message: state.error!,
        onRetry: _refreshInspections,
      );
    }

    if (state.inspections.isEmpty) {
      return const _EmptyState();
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [
        _buildHeader(state),

        const SizedBox(height: 22),

        ...state.inspections.map(
              (inspection) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _InspectionCard(
              assetName: inspection.assetName,
              assetCode: inspection.assetCode,
              status: inspection.status,
              resultSummary: inspection.resultSummary,
              isArAvailable: inspection.isArAvailable,
              onTap: inspection.isArAvailable
                  ? () {
                _openInspection(inspection.id);
              }
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(ArInspectionState state) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2563EB),
            Color(0xFF1D4ED8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),

            child: const Icon(
              Icons.view_in_ar_rounded,
              color: Colors.white,
              size: 34,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  'Inspection Workspace',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  '${state.inspections.length} inspection(s) available',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Inspect assets using augmented reality.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openInspection(int inspectionId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArInspectionDetailScreen(
          inspectionId: inspectionId,
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// Inspection Card
// ------------------------------------------------------------

class _InspectionCard extends StatelessWidget {
  final String assetName;
  final String assetCode;
  final String status;
  final String? resultSummary;
  final bool isArAvailable;
  final VoidCallback? onTap;

  const _InspectionCard({
    required this.assetName,
    required this.assetCode,
    required this.status,
    required this.resultSummary,
    required this.isArAvailable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,

      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Container(
                    padding: const EdgeInsets.all(13),

                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: const Icon(
                      Icons.precision_manufacturing_rounded,
                      color: Color(0xFF2563EB),
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          assetName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,

                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF172B4D),
                          ),
                        ),

                        const SizedBox(height: 6),

                        Row(
                          children: [
                            Icon(
                              Icons.qr_code_rounded,
                              size: 15,
                              color: Colors.grey.shade600,
                            ),

                            const SizedBox(width: 5),

                            Expanded(
                              child: Text(
                                assetCode,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  Icon(
                    isArAvailable
                        ? Icons.arrow_forward_ios_rounded
                        : Icons.lock_outline_rounded,
                    size: 18,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'INSPECTION STATUS',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: Colors.grey.shade500,
                          ),
                        ),

                        const SizedBox(height: 8),

                        _StatusBadge(status: status),
                      ],
                    ),
                  ),

                  if (resultSummary != null)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'RESULT',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                              color: Colors.grey.shade500,
                            ),
                          ),

                          const SizedBox(height: 8),

                          _ResultBadge(
                            resultSummary: resultSummary!,
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),

                decoration: BoxDecoration(
                  color: isArAvailable
                      ? const Color(0xFFF0FDF4)
                      : const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  children: [
                    Icon(
                      isArAvailable
                          ? Icons.check_circle_outline_rounded
                          : Icons.info_outline_rounded,
                      size: 17,
                      color: isArAvailable
                          ? const Color(0xFF16A34A)
                          : Colors.grey.shade600,
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        isArAvailable
                            ? 'AR inspection available'
                            : 'AR inspection unavailable',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isArAvailable
                              ? const Color(0xFF15803D)
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),

                    if (isArAvailable)
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: Color(0xFF16A34A),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// Status Badge
// ------------------------------------------------------------

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final statusData = _getStatusData(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),

      decoration: BoxDecoration(
        color: statusData.backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(
            statusData.icon,
            size: 15,
            color: statusData.foregroundColor,
          ),

          const SizedBox(width: 6),

          Flexible(
            child: Text(
              status,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: statusData.foregroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _StatusData _getStatusData(String status) {
    switch (status.toLowerCase()) {
      case 'ready':
        return _StatusData(
          backgroundColor: const Color(0xFFEFF6FF),
          foregroundColor: const Color(0xFF2563EB),
          icon: Icons.play_circle_outline_rounded,
        );

      case 'in progress':
        return _StatusData(
          backgroundColor: const Color(0xFFFFF7ED),
          foregroundColor: const Color(0xFFC2410C),
          icon: Icons.hourglass_top_rounded,
        );

      case 'completed':
        return _StatusData(
          backgroundColor: const Color(0xFFF0FDF4),
          foregroundColor: const Color(0xFF15803D),
          icon: Icons.check_circle_outline_rounded,
        );

      default:
        return _StatusData(
          backgroundColor: const Color(0xFFF3F4F6),
          foregroundColor: const Color(0xFF4B5563),
          icon: Icons.info_outline_rounded,
        );
    }
  }
}

// ------------------------------------------------------------
// Result Badge
// ------------------------------------------------------------

class _ResultBadge extends StatelessWidget {
  final String resultSummary;

  const _ResultBadge({
    required this.resultSummary,
  });

  @override
  Widget build(BuildContext context) {
    final isPassed =
        resultSummary.toLowerCase() == 'passed';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),

      decoration: BoxDecoration(
        color: isPassed
            ? const Color(0xFFF0FDF4)
            : const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(30),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(
            isPassed
                ? Icons.check_circle_rounded
                : Icons.warning_rounded,
            size: 15,
            color: isPassed
                ? const Color(0xFF15803D)
                : const Color(0xFFDC2626),
          ),

          const SizedBox(width: 6),

          Flexible(
            child: Text(
              resultSummary,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isPassed
                    ? const Color(0xFF15803D)
                    : const Color(0xFFDC2626),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// Supporting Status Data
// ------------------------------------------------------------

class _StatusData {
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;

  const _StatusData({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
  });
}

// ------------------------------------------------------------
// Empty State
// ------------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),

      padding: const EdgeInsets.all(24),

      children: [
        const SizedBox(height: 100),

        Icon(
          Icons.view_in_ar_outlined,
          size: 80,
          color: Colors.grey.shade400,
        ),

        const SizedBox(height: 20),

        const Text(
          'No AR Inspections Yet',
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF172B4D),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'AR inspection records will appear here when they become available.',
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------
// Error State
// ------------------------------------------------------------

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),

      padding: const EdgeInsets.all(24),

      children: [
        const SizedBox(height: 100),

        Icon(
          Icons.error_outline_rounded,
          size: 70,
          color: Colors.red.shade300,
        ),

        const SizedBox(height: 20),

        const Text(
          'Something Went Wrong',
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          message,
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 24),

        Center(
          child: ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Try Again'),
          ),
        ),
      ],
    );
  }
}