import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/ar_inspection_provider.dart';
import 'ar_inspection_experience_screen.dart';

class ArInspectionDetailScreen extends ConsumerStatefulWidget {
  final int inspectionId;

  const ArInspectionDetailScreen({
    super.key,
    required this.inspectionId,
  });

  @override
  ConsumerState<ArInspectionDetailScreen> createState() =>
      _ArInspectionDetailScreenState();
}

class _ArInspectionDetailScreenState
    extends ConsumerState<ArInspectionDetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(arInspectionProvider.notifier)
          .getArInspectionById(widget.inspectionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(arInspectionProvider);
    final inspection = state.selectedInspection;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172033),
        title: const Text(
          'Inspection Details',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: _buildBody(state, inspection),
    );
  }

  Widget _buildBody(
      dynamic state,
      dynamic inspection,
      ) {
    if (state.isLoading && inspection == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.error != null && inspection == null) {
      return _ErrorState(
        message: state.error!,
        onRetry: () {
          ref
              .read(arInspectionProvider.notifier)
              .getArInspectionById(widget.inspectionId);
        },
      );
    }

    if (inspection == null) {
      return const _EmptyState();
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAssetHeader(inspection),

          const SizedBox(height: 24),

          _SectionTitle(
            title: 'Inspection Overview',
            subtitle: 'Basic information about this inspection',
          ),

          const SizedBox(height: 14),

          _InfoGrid(
            children: [
              _InfoCard(
                title: 'Asset ID',
                value: inspection.assetId.toString(),
                icon: Icons.tag_rounded,
              ),
              _InfoCard(
                title: 'Asset Code',
                value: inspection.assetCode,
                icon: Icons.qr_code_rounded,
              ),
              _InfoCard(
                title: 'AR Availability',
                value: inspection.isArAvailable
                    ? 'Available'
                    : 'Unavailable',
                icon: Icons.view_in_ar_rounded,
                valueColor: inspection.isArAvailable
                    ? Colors.green.shade700
                    : Colors.red.shade700,
              ),
              _InfoCard(
                title: 'Status',
                value: inspection.status,
                icon: Icons.timeline_rounded,
                valueColor: _getStatusColor(inspection.status),
              ),
            ],
          ),

          if (inspection.resultSummary != null) ...[
            const SizedBox(height: 24),

            const _SectionTitle(
              title: 'Inspection Result',
              subtitle: 'Summary of the completed inspection',
            ),

            const SizedBox(height: 14),

            _ResultSummaryCard(
              resultSummary: inspection.resultSummary!,
            ),
          ],

          const SizedBox(height: 28),

          _buildActionSection(inspection),

          const SizedBox(height: 20),

          _buildStatusMessage(inspection),
        ],
      ),
    );
  }

  Widget _buildAssetHeader(dynamic inspection) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2563EB),
            Color(0xFF1D4ED8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.20),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.view_in_ar_rounded,
              color: Colors.white,
              size: 52,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            inspection.assetName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            inspection.assetCode,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.shield_outlined,
                  color: Colors.white,
                  size: 17,
                ),
                const SizedBox(width: 8),
                Text(
                  inspection.isArAvailable
                      ? 'AR Inspection Available'
                      : 'AR Inspection Unavailable',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection(dynamic inspection) {
    if (inspection.status == 'Completed') {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.green.withValues(alpha: 0.25),
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Colors.green.shade600,
              size: 42,
            ),
            const SizedBox(height: 12),
            const Text(
              'Inspection Completed',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'This inspection has already been completed.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Inspection Actions',
          subtitle: 'Start or continue the AR inspection process',
        ),

        const SizedBox(height: 14),

        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: inspection.isArAvailable
                ? _startArInspection
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              disabledForegroundColor: Colors.grey.shade600,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            icon: Icon(
              inspection.status == 'In Progress'
                  ? Icons.play_arrow_rounded
                  : Icons.view_in_ar_rounded,
            ),
            label: Text(
              inspection.status == 'In Progress'
                  ? 'Continue AR Inspection'
                  : 'Start AR Inspection',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusMessage(dynamic inspection) {
    if (inspection.status == 'In Progress') {
      return _StatusMessage(
        icon: Icons.hourglass_top_rounded,
        title: 'Inspection In Progress',
        message:
        'This inspection has been started. Continue the process to complete all inspection points.',
        backgroundColor: Colors.orange.shade50,
        foregroundColor: Colors.orange.shade800,
      );
    }

    if (inspection.status == 'Completed') {
      return _StatusMessage(
        icon: Icons.check_circle_outline_rounded,
        title: 'Inspection Successfully Completed',
        message:
        'The inspection process has been completed and the result is available above.',
        backgroundColor: Colors.green.shade50,
        foregroundColor: Colors.green.shade800,
      );
    }

    return _StatusMessage(
      icon: Icons.info_outline_rounded,
      title: 'Ready for Inspection',
      message:
      'Start the AR inspection to examine the asset and record inspection results.',
      backgroundColor: Colors.blue.shade50,
      foregroundColor: Colors.blue.shade800,
    );
  }

  Future<void> _startArInspection() async {
    await ref
        .read(arInspectionProvider.notifier)
        .startInspection(widget.inspectionId);

    if (!mounted) return;

    final state = ref.read(arInspectionProvider);

    if (state.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error!),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final inspection = state.startedInspection;

    if (inspection == null) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArInspectionExperienceScreen(
          arInspectionId: inspection.id,
          inspectionId: inspection.inspectionId!,
          assetName: inspection.assetName,
          assetCode: inspection.assetCode,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green.shade700;
      case 'in progress':
        return Colors.orange.shade700;
      case 'ready':
        return Colors.blue.shade700;
      default:
        return Colors.grey.shade700;
    }
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: Color(0xFF172033),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final List<Widget> children;

  const _InfoGrid({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.35,
      children: children,
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xFF2563EB),
            size: 22,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: valueColor ?? const Color(0xFF172033),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultSummaryCard extends StatelessWidget {
  final String resultSummary;

  const _ResultSummaryCard({
    required this.resultSummary,
  });

  @override
  Widget build(BuildContext context) {
    final isPassed = resultSummary.toLowerCase() == 'passed';

    final foregroundColor =
    isPassed ? Colors.green.shade700 : Colors.red.shade700;

    final backgroundColor =
    isPassed ? Colors.green.shade50 : Colors.red.shade50;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: foregroundColor.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isPassed
                ? Icons.check_circle_rounded
                : Icons.warning_rounded,
            color: foregroundColor,
            size: 36,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Inspection Result',
                  style: TextStyle(
                    fontSize: 12,
                    color: foregroundColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  resultSummary,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: foregroundColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final Color backgroundColor;
  final Color foregroundColor;

  const _StatusMessage({
    required this.icon,
    required this.title,
    required this.message,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: foregroundColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: foregroundColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: TextStyle(
                    color: foregroundColor,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: Colors.red.shade400,
              size: 55,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 60,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'AR inspection not found.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}