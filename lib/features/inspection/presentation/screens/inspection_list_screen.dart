import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../assets/domain/entities/asset.dart';
import '../../../assets/presentation/providers/asset_notifier.dart';
import '../providers/inspection_notifier.dart';
import '../providers/inspection_state.dart';
import 'inspection_details_screen.dart';


class InspectionListScreen extends ConsumerStatefulWidget {
  const InspectionListScreen({super.key});

  @override
  ConsumerState<InspectionListScreen> createState() =>
      _InspectionListScreenState();
}

class _InspectionListScreenState
    extends ConsumerState<InspectionListScreen> {
  final Map<int, Asset> _assets = {};
  String _selectedFilter = 'All';
  String _searchQuery = '';
  bool _newestFirst = true;

  final List<String> _filters = [
    'All',
    'In Progress',
    'Completed',
    'Other',
  ];

  @override
  void initState() {
    super.initState();

    Future.microtask(_loadInspections);
  }

  Future<void> _loadInspections() async {
    await ref
        .read(inspectionProvider.notifier)
        .getInspections();

    if (!mounted) return;

    final inspections =
        ref.read(inspectionProvider).inspections;

    for (final inspection in inspections) {
      await _loadAsset(inspection.assetId);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadAsset(int assetId) async {
    try {
      await ref
          .read(assetProvider.notifier)
          .getAssetById(assetId);

      final assetState = ref.read(assetProvider);
      final asset = assetState.selectedAsset;

      if (asset != null && mounted) {
        _assets[assetId] = asset;
      }
    } catch (_) {
      // The inspection remains visible if asset loading fails.
    }
  }

  Future<void> _refreshInspections() async {
    _assets.clear();
    await _loadInspections();
  }

  @override
  Widget build(BuildContext context) {
    final inspectionState = ref.watch(inspectionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspection History'),
        actions: [
          IconButton(
            onPressed: inspectionState.isLoading
                ? null
                : _refreshInspections,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
    children: [


      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search by inspection ID, asset name or code',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Clear search',
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                });
              },
            )
                : null,
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value.trim().toLowerCase();
            });
          },
        ),
      ),

      SingleChildScrollView(
    scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
            ),
          );
        }).toList(),
      ),
    ),

      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: Row(
          children: [
            const Icon(Icons.sort, size: 20),
            const SizedBox(width: 8),
            const Text('Sort by date:'),
            const SizedBox(width: 12),
            DropdownButton<bool>(
              value: _newestFirst,
              items: const [
                DropdownMenuItem<bool>(
                  value: true,
                  child: Text('Newest first'),
                ),
                DropdownMenuItem<bool>(
                  value: false,
                  child: Text('Oldest first'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _newestFirst = value;
                });
              },
            ),
          ],
        ),
      ),

      Expanded(
    child: _buildBody(inspectionState),
    ),
    ],
    ),
    );
  }

  Widget _buildBody(InspectionState state) {

    final filteredInspections = state.inspections.where((inspection) {
      final status = inspection.status.toLowerCase();

      // Apply the selected status filter.
      final matchesStatus = switch (_selectedFilter) {
        'In Progress' => status == 'in progress',
        'Completed' => status == 'completed',
        'Other' => status != 'in progress' && status != 'completed',
        _ => true,
      };

      // Search by inspection ID, asset name, or asset code.
      final asset = _assets[inspection.assetId];

      final matchesSearch =
          inspection.id.toString().contains(_searchQuery) ||
              (asset?.name.toLowerCase().contains(_searchQuery) ?? false) ||
              (asset?.assetCode.toLowerCase().contains(_searchQuery) ?? false);

      return matchesStatus && matchesSearch;
    }).toList();
    filteredInspections.sort((a, b) {
      final comparison = a.inspectionDate.compareTo(b.inspectionDate);

      return _newestFirst ? -comparison : comparison;
    });


    if (state.isLoading && state.inspections.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.error != null && state.inspections.isEmpty) {
      return _ErrorMessage(
        message: state.error!,
        onRetry: _refreshInspections,
      );
    }

    if (state.inspections.isEmpty) {
      return RefreshIndicator(
        onRefresh: _refreshInspections,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 180),
          Center(
            child: Text(
              _selectedFilter == 'All'
                  ? 'No inspections found'
                  : 'No $_selectedFilter inspections found',
              textAlign: TextAlign.center,
            ),
          ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshInspections,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),

        itemCount: filteredInspections.length,
        itemBuilder: (context, index) {

          final inspection = filteredInspections[index];
          final asset = _assets[inspection.assetId];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InspectionDetailsScreen(
                      inspectionId: inspection.id,
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundColor:
                Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  Icons.assignment_outlined,
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer,
                ),
              ),
              title: Text(
                'Inspection #${inspection.id}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  Icons.precision_manufacturing_outlined,
                  asset == null
                      ? 'Asset ID: ${inspection.assetId}'
                      : '${asset.name} (${asset.assetCode})',
                ),
                if (asset != null) ...[
                  const SizedBox(height: 5),
                  _buildInfoRow(
                    Icons.location_on_outlined,
                    asset.location,
                  ),
                ],
                const SizedBox(height: 5),
                _buildInfoRow(
                  Icons.person_outline,
                  'Engineer ID: ${inspection.engineerId}',
                ),
                const SizedBox(height: 5),
                _buildInfoRow(
                  Icons.calendar_today_outlined,
                  _formatInspectionDate(inspection.inspectionDate),
                ),
              ],
            ),
          ),

          trailing: _StatusBadge(
                status: inspection.status,
              ),
            ),
          );
        },
      ),
    );
  }
  String _formatInspectionDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;

    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$day/$month/$year, '
        '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

 /* String _buildInspectionDetails(
      dynamic inspection,
      Asset? asset,
      ) {
    final inspectionAsset = asset == null
        ? 'Asset ID: ${inspection.assetId}'
        : '${asset.name}\n'
        'Asset Code: ${asset.assetCode}\n'
        'Location: ${asset.location}';

    return '$inspectionAsset\n'
        'Engineer ID: ${inspection.engineerId}\n'
        //'Date: ${inspection.inspectionDate}';
    //'Date: ${DateFormat('dd MMM yyyy, hh:mm a').format(inspection.inspectionDate)}';
        'Date: ${_formatInspectionDate(inspection.inspectionDate)}';
  }*/
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final isCompleted = status.toLowerCase() == 'completed';

    final backgroundColor = isCompleted
        ? Colors.green.shade100
        : colorScheme.secondaryContainer;

    final textColor = isCompleted
        ? Colors.green.shade800
        : colorScheme.onSecondaryContainer;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
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