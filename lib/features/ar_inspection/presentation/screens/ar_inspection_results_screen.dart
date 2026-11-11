import 'package:flutter/material.dart';

import '../../domain/entities/ar_inspection_result.dart';

class ArInspectionResultsScreen extends StatelessWidget {
  final String assetName;
  final String assetCode;
  final List<ArInspectionResult> results;

  const ArInspectionResultsScreen({
    super.key,
    required this.assetName,
    required this.assetCode,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    final passedCount =
        results.where((result) => result.isPassed).length;

    final failedCount =
        results.where((result) => !result.isPassed).length;

    final totalCount = results.length;

    final overallPassed =
        totalCount > 0 && failedCount == 0;

    final completionPercentage = totalCount == 0
        ? 0
        : ((passedCount / totalCount) * 100).round();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172B4D),
        title: const Text(
          'Inspection Results',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Asset Header
            _AssetHeader(
              assetName: assetName,
              assetCode: assetCode,
            ),

            const SizedBox(height: 24),

            // Page Heading
            const Text(
              'Inspection Summary',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF172B4D),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Review the inspection results for this asset.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 18),

            // Overall Result Card
            _OverallResultCard(
              overallPassed: overallPassed,
              totalCount: totalCount,
              completionPercentage: completionPercentage,
            ),

            const SizedBox(height: 20),

            // Statistics
            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: 'Total',
                    value: totalCount.toString(),
                    icon: Icons.assignment_outlined,
                    iconColor: const Color(0xFF2563EB),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _SummaryCard(
                    title: 'Passed',
                    value: passedCount.toString(),
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.green.shade600,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _SummaryCard(
                    title: 'Failed',
                    value: failedCount.toString(),
                    icon: Icons.cancel_outlined,
                    iconColor: Colors.red.shade600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Inspection Points Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Inspection Points',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172B4D),
                  ),
                ),
                if (totalCount > 0)
                  Text(
                    '$totalCount Points',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 14),

            // Results List
            if (results.isEmpty)
              _EmptyResultsCard()
            else
              ListView.separated(
                itemCount: results.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
                itemBuilder: (context, index) {
                  final result = results[index];

                  return _InspectionResultCard(
                    result: result,
                    index: index,
                  );
                },
              ),

            const SizedBox(height: 28),

            // Back Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text(
                  'Back to AR Inspection',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// Asset Header
// ------------------------------------------------------------

class _AssetHeader extends StatelessWidget {
  final String assetName;
  final String assetCode;

  const _AssetHeader({
    required this.assetName,
    required this.assetCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
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
            color: Colors.blue.withValues(alpha: 0.20),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.precision_manufacturing_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'INSPECTED ASSET',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  assetName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  assetCode,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
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

// ------------------------------------------------------------
// Overall Result Card
// ------------------------------------------------------------

class _OverallResultCard extends StatelessWidget {
  final bool overallPassed;
  final int totalCount;
  final int completionPercentage;

  const _OverallResultCard({
    required this.overallPassed,
    required this.totalCount,
    required this.completionPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final hasResults = totalCount > 0;

    final backgroundColor = !hasResults
        ? Colors.grey.shade100
        : overallPassed
        ? Colors.green.shade50
        : Colors.red.shade50;

    final primaryColor = !hasResults
        ? Colors.grey.shade700
        : overallPassed
        ? Colors.green.shade700
        : Colors.red.shade700;

    final icon = !hasResults
        ? Icons.info_outline_rounded
        : overallPassed
        ? Icons.check_circle_rounded
        : Icons.warning_rounded;

    final title = !hasResults
        ? 'No Results Available'
        : overallPassed
        ? 'Inspection Passed'
        : 'Inspection Requires Attention';

    final subtitle = !hasResults
        ? 'There are no recorded inspection points.'
        : overallPassed
        ? 'All inspection points passed successfully.'
        : 'One or more inspection points require maintenance.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 58,
            color: primaryColor,
          ),

          const SizedBox(height: 12),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: primaryColor.withValues(alpha: 0.80),
            ),
          ),

          if (hasResults) ...[
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pass Rate',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  '$completionPercentage%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: completionPercentage / 100,
                minHeight: 8,
                backgroundColor: primaryColor.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation<Color>(
                  primaryColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// Summary Card
// ------------------------------------------------------------

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 26,
            color: iconColor,
          ),

          const SizedBox(height: 9),

          Text(
            value,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color(0xFF172B4D),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// Inspection Result Card
// ------------------------------------------------------------

class _InspectionResultCard extends StatelessWidget {
  final ArInspectionResult result;
  final int index;

  const _InspectionResultCard({
    required this.result,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isPassed = result.isPassed;

    final statusColor =
    isPassed ? Colors.green.shade700 : Colors.red.shade700;

    final statusBackground =
    isPassed ? Colors.green.shade50 : Colors.red.shade50;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: statusBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              isPassed
                  ? Icons.check_circle_outline_rounded
                  : Icons.cancel_outlined,
              color: statusColor,
              size: 27,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'POINT ${index + 1}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.grey.shade500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  result.inspectionPoint,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172B4D),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: statusBackground,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              isPassed ? 'PASS' : 'FAIL',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// Empty Results Card
// ------------------------------------------------------------

class _EmptyResultsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.assignment_late_outlined,
            size: 48,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 12),

          Text(
            'No inspection results found.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}