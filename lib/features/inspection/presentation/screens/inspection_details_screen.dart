import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../maintenance/presentation/screens/maintenance_screen.dart';
import '../../domain/entities/inspection.dart';
import '../providers/inspection_notifier.dart';
import '../providers/inspection_state.dart';
import 'checklist_screen.dart';
import 'evidence_screen.dart';

class InspectionDetailsScreen extends ConsumerStatefulWidget {
  final int inspectionId;

  const InspectionDetailsScreen({
    super.key,
    required this.inspectionId,
  });

  @override
  ConsumerState<InspectionDetailsScreen> createState() =>
      _InspectionDetailsScreenState();
}

class _InspectionDetailsScreenState
    extends ConsumerState<InspectionDetailsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(inspectionProvider.notifier)
          .getInspectionById(widget.inspectionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inspectionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspection Details'),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(InspectionState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.error != null) {
      return _ErrorMessage(
        message: state.error!,
        onRetry: () {
          ref
              .read(inspectionProvider.notifier)
              .getInspectionById(widget.inspectionId);
        },
      );
    }

    final inspection = state.selectedInspection;

    if (inspection == null) {
      return const Center(
        child: Text('Inspection not found'),
      );
    }

    return _buildDetails(inspection);
  }

  Widget _buildDetails(Inspection inspection) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.assignment_outlined,
                size: 80,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Inspection #${inspection.id}',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          _DetailRow(
            label: 'Asset ID',
            value: inspection.assetId.toString(),
            icon: Icons.precision_manufacturing,
          ),

          _DetailRow(
            label: 'Engineer ID',
            value: inspection.engineerId,
            icon: Icons.engineering_outlined,
          ),

          _DetailRow(
            label: 'Inspection Date',
            value: inspection.inspectionDate.toString(),
            icon: Icons.calendar_today_outlined,
          ),

          _DetailRow(
            label: 'Status',
            value: inspection.status,
            icon: Icons.info_outline,
          ),

          const SizedBox(height: 24),

          Text(
            'Inspection Actions',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChecklistScreen(
                      inspectionId: inspection.id,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.checklist),
              label: const Text('View Checklist'),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EvidenceScreen(
                      inspectionId: inspection.id,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.photo_library_outlined),
              label: const Text('View Evidence'),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MaintenanceScreen(
                      inspectionId: inspection.id,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.build_outlined),
              label: const Text('Maintenance'),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelLarge,
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
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
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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

            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}