import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../maintenance/presentation/providers/maintenance_provider.dart';
import '../providers/ar_inspection_provider.dart';
import 'ar_inspection_results_screen.dart';

class ArInspectionExperienceScreen extends ConsumerStatefulWidget {
  final int arInspectionId;
  final int inspectionId;
  final String assetName;
  final String assetCode;

  const ArInspectionExperienceScreen({
    super.key,
    required this.arInspectionId,
    required this.inspectionId,
    required this.assetName,
    required this.assetCode,
  });

  @override
  ConsumerState<ArInspectionExperienceScreen> createState() =>
      _ArInspectionExperienceScreenState();
}

class _ArInspectionExperienceScreenState
    extends ConsumerState<ArInspectionExperienceScreen> {
  final List<String> _inspectionPoints = [
    'Oil Level',
    'Temperature',
    'Vibration',
    'Leakage',
    'Motor Condition',
  ];

  int _currentPoint = 0;

  final Map<int, bool> _results = {};

  bool _isSaving = false;

  Future<void> _markResult(bool passed) async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    final currentPointName = _inspectionPoints[_currentPoint];

    final result = await ref
        .read(arInspectionProvider.notifier)
        .saveInspectionResult(
      arInspectionId: widget.arInspectionId,
      inspectionPoint: currentPointName,
      isPassed: passed,
    );

    if (!mounted) return;

    if (result == null) {
      setState(() {
        _isSaving = false;
      });

      final error = ref.read(arInspectionProvider).error;

      _showSnackBar(
        error ?? 'Failed to save inspection result.',
        isError: true,
      );

      return;
    }

    if (!passed) {
      final maintenanceRecord = await ref
          .read(maintenanceProvider.notifier)
          .createFromArFailure(
        inspectionId: widget.inspectionId,
        issue: '$currentPointName inspection failed',
        description:
        'AR inspection detected a failure at $currentPointName.',
        priority: 'High',
      );

      if (!mounted) return;

      if (maintenanceRecord == null) {
        setState(() {
          _isSaving = false;
        });

        final maintenanceError =
            ref.read(maintenanceProvider).error;

        _showSnackBar(
          maintenanceError ??
              'AR result saved, but maintenance record could not be created.',
          isError: true,
        );

        return;
      }
    }

    setState(() {
      _results[_currentPoint] = passed;
      _isSaving = false;

      if (_currentPoint < _inspectionPoints.length - 1) {
        _currentPoint++;
      }
    });

    _showSnackBar(
      passed
          ? '$currentPointName: PASS saved.'
          : '$currentPointName: FAIL saved and maintenance record created.',
      isError: !passed,
    );
  }

  void _showSnackBar(
      String message, {
        bool isError = false,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor:
        isError ? Colors.orange.shade800 : Colors.green.shade700,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _results.length;
    final totalPoints = _inspectionPoints.length;
    final isCompleted = completedCount == totalPoints;

    final currentPointName = isCompleted
        ? 'Inspection Complete'
        : _inspectionPoints[_currentPoint];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172033),
        title: const Text(
          'AR Inspection',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${completedCount + (isCompleted ? 0 : 1)}/$totalPoints',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAssetHeader(),

                    const SizedBox(height: 20),

                    _buildProgressCard(
                      completedCount,
                      totalPoints,
                    ),

                    const SizedBox(height: 20),

                    _buildArView(currentPointName, isCompleted),

                    const SizedBox(height: 24),

                    _buildInspectionPoints(),

                    const SizedBox(height: 22),

                    if (!isCompleted) _buildCurrentInspectionCard(),

                    if (isCompleted) _buildCompletionCard(),
                  ],
                ),
              ),
            ),

            if (!isCompleted) _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.precision_manufacturing_rounded,
              size: 32,
              color: Colors.blue.shade700,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.assetName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF172033),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  widget.assetCode,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(
      int completedCount,
      int totalPoints,
      ) {
    final progress = completedCount / totalPoints;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2563EB),
            Color(0xFF1D4ED8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Inspection Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor: Colors.white.withValues(alpha: 0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            '$completedCount of $totalPoints inspection points completed',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArView(
      String currentPointName,
      bool isCompleted,
      ) {
    return Container(
      width: double.infinity,
      height: 230,
      decoration: BoxDecoration(
        color: const Color(0xFF101827),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.view_in_ar_rounded,
                  size: 76,
                  color: Colors.white.withValues(alpha: 0.65),
                ),

                const SizedBox(height: 10),

                Text(
                  isCompleted
                      ? 'Inspection Complete'
                      : 'AR Asset Scanner',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    size: 8,
                    color: Colors.greenAccent,
                  ),
                  SizedBox(width: 7),
                  Text(
                    'AR VIEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),

          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                isCompleted
                    ? 'All inspection points completed'
                    : 'Scanning: $currentPointName',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInspectionPoints() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Inspection Checklist',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: Color(0xFF172033),
          ),
        ),

        const SizedBox(height: 5),

        Text(
          'Review each point and record its condition.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 14),

        ...List.generate(
          _inspectionPoints.length,
              (index) => _buildPointTile(index),
        ),
      ],
    );
  }

  Widget _buildPointTile(int index) {
    final pointName = _inspectionPoints[index];
    final result = _results[index];
    final isCurrent = index == _currentPoint && result == null;

    final isPassed = result == true;
    final isFailed = result == false;

    Color backgroundColor = Colors.white;
    Color iconBackground = Colors.grey.shade100;
    Color iconColor = Colors.grey.shade600;
    IconData icon = Icons.radio_button_unchecked_rounded;

    if (isPassed) {
      backgroundColor = Colors.green.shade50;
      iconBackground = Colors.green.shade100;
      iconColor = Colors.green.shade700;
      icon = Icons.check_circle_rounded;
    } else if (isFailed) {
      backgroundColor = Colors.red.shade50;
      iconBackground = Colors.red.shade100;
      iconColor = Colors.red.shade700;
      icon = Icons.cancel_rounded;
    } else if (isCurrent) {
      backgroundColor = Colors.blue.shade50;
      iconBackground = Colors.blue.shade100;
      iconColor = Colors.blue.shade700;
      icon = Icons.play_circle_fill_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrent
              ? Colors.blue.shade200
              : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Point ${index + 1}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  pointName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
              ],
            ),
          ),

          _buildPointStatus(result, isCurrent),
        ],
      ),
    );
  }

  Widget _buildPointStatus(
      bool? result,
      bool isCurrent,
      ) {
    if (result == true) {
      return _SmallStatusBadge(
        label: 'PASS',
        color: Colors.green.shade700,
      );
    }

    if (result == false) {
      return _SmallStatusBadge(
        label: 'FAIL',
        color: Colors.red.shade700,
      );
    }

    if (isCurrent) {
      return _SmallStatusBadge(
        label: 'CURRENT',
        color: Colors.blue.shade700,
      );
    }

    return _SmallStatusBadge(
      label: 'PENDING',
      color: Colors.grey.shade600,
    );
  }

  Widget _buildCurrentInspectionCard() {
    final currentPointName = _inspectionPoints[_currentPoint];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.fact_check_outlined,
                color: Colors.blue.shade700,
                size: 23,
              ),

              const SizedBox(width: 10),

              const Text(
                'Current Inspection Point',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF172033),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              currentPointName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.blue.shade800,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Inspect this component carefully, then select PASS or FAIL.',
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.green.shade100,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.check_circle_rounded,
            color: Colors.green.shade700,
            size: 54,
          ),

          const SizedBox(height: 12),

          const Text(
            'All Inspection Points Completed',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Review your results and complete the AR inspection.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: _isSaving ? null : _showCompletionDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.done_all_rounded),
              label: const Text(
                'Complete AR Inspection',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 54,
              child: ElevatedButton.icon(
                onPressed: _isSaving
                    ? null
                    : () {
                  _markResult(true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const Icon(Icons.check_rounded),
                label: const Text(
                  'PASS',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: SizedBox(
              height: 54,
              child: ElevatedButton.icon(
                onPressed: _isSaving
                    ? null
                    : () {
                  _markResult(false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const Icon(Icons.close_rounded),
                label: const Text(
                  'FAIL',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCompletionDialog() async {
    setState(() {
      _isSaving = true;
    });

    await ref
        .read(arInspectionProvider.notifier)
        .completeInspection(widget.arInspectionId);

    if (!mounted) return;

    final state = ref.read(arInspectionProvider);

    if (state.error != null) {
      setState(() {
        _isSaving = false;
      });

      _showSnackBar(
        state.error!,
        isError: true,
      );

      return;
    }

    await ref
        .read(arInspectionProvider.notifier)
        .loadInspectionResults(widget.arInspectionId);

    if (!mounted) return;

    final updatedState = ref.read(arInspectionProvider);

    if (updatedState.error != null) {
      setState(() {
        _isSaving = false;
      });

      _showSnackBar(
        updatedState.error!,
        isError: true,
      );

      return;
    }

    setState(() {
      _isSaving = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArInspectionResultsScreen(
          assetName: widget.assetName,
          assetCode: widget.assetCode,
          results: updatedState.inspectionResults,
        ),
      ),
    );
  }
}

class _SmallStatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _SmallStatusBadge({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}