
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/presentation/providers/authentication_notifier.dart';
import '../../../inspection/presentation/providers/inspection_notifier.dart';
import '../../../inspection/presentation/screens/inspection_screen.dart';
import '../providers/asset_notifier.dart';
import '../providers/asset_state.dart';
import 'edit_asset_screen.dart';
import '../../domain/entities/asset.dart';

class AssetDetailsScreen extends ConsumerStatefulWidget {
  final int assetId;

  const AssetDetailsScreen({
    super.key,
    required this.assetId,
  });

  @override
  ConsumerState<AssetDetailsScreen> createState() =>
      _AssetDetailsScreenState();
}

class _AssetDetailsScreenState
    extends ConsumerState<AssetDetailsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(assetProvider.notifier)
          .getAssetById(widget.assetId);
    });
  }

  Future<void> _startInspection() async {
    final authState = ref.read(authenticationProvider);
    final engineer = authState.engineer;

    if (engineer == null) {
      _showMessage('Engineer is not logged in');
      return;
    }

    final assetState = ref.read(assetProvider);
    final asset = assetState.selectedAsset;

    if (asset == null) {
      _showMessage('Asset not found');
      return;
    }

    await ref
        .read(inspectionProvider.notifier)
        .createInspection(
      assetId: asset.id,
      engineerId: engineer.id.toString(),
    );

    if (!mounted) return;

    final inspectionState = ref.read(inspectionProvider);

    if (inspectionState.error != null) {
      _showMessage(inspectionState.error!);
      return;
    }

    final inspection = inspectionState.createdInspection;

    if (inspection != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => InspectionScreen(
            inspection: inspection,
          ),
        ),
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _editAsset( Asset asset) async {
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => EditAssetScreen(asset: asset),
      ),
    );

    if (updated == true && mounted) {
      await ref
          .read(assetProvider.notifier)
          .getAssetById(widget.assetId);
    }
  }
  Future<void> _deleteAsset(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Asset'),
          content: const Text(
            'Are you sure you want to delete this asset? '
                'This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm != true || !mounted) return;

    try {
      await ref.read(assetProvider.notifier).deleteAsset(id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Asset deleted successfully!'),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      _showMessage('Failed to delete asset: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final assetState = ref.watch(assetProvider);
    final inspectionState = ref.watch(inspectionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Details'),
      ),
      body: _buildBody(
        assetState,
        inspectionState.isLoading,
      ),
    );
  }

  Widget _buildBody(
      AssetState state,
      bool isCreatingInspection,
      ) {
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
              .read(assetProvider.notifier)
              .getAssetById(widget.assetId);
        },
      );
    }

    final asset = state.selectedAsset;

    if (asset == null) {
      return const Center(
        child: Text('Asset not found'),
      );
    }

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
                Icons.precision_manufacturing,
                size: 80,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            asset.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          _DetailRow(
            label: 'Asset Code',
            value: asset.assetCode,
            icon: Icons.qr_code,
          ),

          _DetailRow(
            label: 'Location',
            value: asset.location,
            icon: Icons.location_on_outlined,
          ),

          _DetailRow(
            label: 'Status',
            value: asset.status,
            icon: Icons.info_outline,
          ),

          const SizedBox(height: 32),

          // Edit Asset Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _editAsset(asset),
              icon: const Icon(Icons.edit),
              label: const Text('Edit Asset'),
            ),
          ),

          const SizedBox(height: 12),


          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _deleteAsset(asset.id),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Delete Asset'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Start Inspection Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isCreatingInspection
                  ? null
                  : _startInspection,
              icon: isCreatingInspection
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
                  : const Icon(Icons.assignment_outlined),
              label: Text(
                isCreatingInspection
                    ? 'Creating Inspection...'
                    : 'Start Inspection',
              ),
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
    final colorScheme = Theme.of(context).colorScheme;

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
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge,
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
