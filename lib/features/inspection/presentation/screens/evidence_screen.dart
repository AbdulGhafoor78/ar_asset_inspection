import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/evidence_notifier.dart';
import '../providers/evidence_state.dart';

class EvidenceScreen extends ConsumerStatefulWidget {
  final int inspectionId;

  const EvidenceScreen({
    super.key,
    required this.inspectionId,
  });

  @override
  ConsumerState<EvidenceScreen> createState() =>
      _EvidenceScreenState();
}

class _EvidenceScreenState
    extends ConsumerState<EvidenceScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(evidenceProvider.notifier)
          .getEvidence(widget.inspectionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(evidenceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspection Evidence'),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(EvidenceState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.error != null) {
      return Center(
        child: Text(
          state.error!,
          textAlign: TextAlign.center,
        ),
      );
    }

    if (state.evidence.isEmpty) {
      return const Center(
        child: Text(
          'No evidence found for this inspection',
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.evidence.length,
      itemBuilder: (context, index) {
        final evidence = state.evidence[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(

            leading: (evidence.imageBytes != null &&
                evidence.imageBytes!.isNotEmpty)
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(

                Uint8List.fromList(evidence.imageBytes!),
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    width: 64,
                    height: 64,
                    child: Icon(Icons.broken_image),
                  );
                },
              ),
            )
                : const CircleAvatar(
              child: Icon(Icons.image),
            ),

            title: Text(
              evidence.imagePath.split(
                RegExp(r'[/\\]'),
              ).last,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Checklist Item: '
                      '${evidence.checklistItemId}',
                ),

                if (evidence.description != null &&
                    evidence.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      evidence.description!,
                    ),
                  ),

                const SizedBox(height: 4),

                Text(
                  'Added: ${evidence.createdAt}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}