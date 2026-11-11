import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/inspection_checklist_item.dart';
import 'dart:typed_data';


import '../providers/checklist_notifier.dart';
import '../providers/checklist_state.dart';
import '../providers/evidence_state.dart';
import '../providers/inspection_notifier.dart';
import '../providers/evidence_notifier.dart';


class ChecklistScreen extends ConsumerStatefulWidget {
  final int inspectionId;

  const ChecklistScreen({
    super.key,
    required this.inspectionId,
  });

  @override
  ConsumerState<ChecklistScreen> createState() =>
      _ChecklistScreenState();
}

class _ChecklistScreenState
    extends ConsumerState<ChecklistScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(inspectionProvider.notifier)
          .getInspectionById(widget.inspectionId);

      ref
          .read(checklistProvider.notifier)
          .getChecklistItems(widget.inspectionId);
      ref
          .read(evidenceProvider.notifier)
          .getEvidence(widget.inspectionId);
    });
  }
  String _fileName(String path) {
    return path.split(RegExp(r'[/\\]')).last;
  }
  Future<void> _addEvidence(
      InspectionChecklistItem item,
      ) async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (image == null) {
      return;
      //final imageBytes = await image.readAsBytes();
    }
    final imageBytes = await image.readAsBytes();

    if (!mounted) {
      return;
    }

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) {
      return;
    }

    final descriptionController = TextEditingController();

    final description = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Evidence Description'),
          content: TextField(
            controller: descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Describe what you found...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(
                  descriptionController.text.trim(),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    descriptionController.dispose();

    if (description == null || !mounted) {
      return;
    }

    await ref
        .read(evidenceProvider.notifier)
        .addEvidence(
      inspectionId: widget.inspectionId,
      checklistItemId: item.id,
      imagePath: image.name,
      imageBytes: imageBytes,
      description: description.isEmpty
          ? null
          : description,
    );
  }
  Future<void> _confirmDeleteEvidence(int evidenceId) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Evidence'),
          content: const Text(
            'Are you sure you want to delete this evidence?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    await ref
        .read(evidenceProvider.notifier)
        .deleteEvidence(evidenceId);

    if (!mounted) return;

    final error = ref.read(evidenceProvider).error;

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Evidence deleted successfully'),
      ),
    );
  }
  Future<void> _showNotesDialog(
      InspectionChecklistItem item,
      ) async {
    final controller = TextEditingController(
      text: item.notes ?? '',
    );

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notes - ${item.title}'),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Enter inspection notes',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(checklistProvider.notifier)
                    .updateChecklistItem(
                  itemId: item.id,
                  isPassed: item.isPassed,
                  notes: controller.text.trim(),
                );

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    controller.dispose();
  }
  bool _areAllItemsPassed(ChecklistState state) {
    if (state.items.isEmpty) {
      return false;
    }

    return state.items.every(
          (item) => item.isPassed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final checklistState = ref.watch(checklistProvider);
    final inspectionState = ref.watch(inspectionProvider);
    final evidenceState = ref.watch(evidenceProvider);
    final isCompleted = inspectionState.selectedInspection?.status == 'Completed';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspection Checklist'),
      ),
      body: _buildBody(checklistState,evidenceState,  isCompleted),
    );
  }

  Widget _buildBody(ChecklistState state, EvidenceState evidenceState, bool isCompleted) {
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

    if (state.items.isEmpty) {
      return const Center(
        child: Text('No checklist items found'),
      );
    }

    final allItemsPassed = _areAllItemsPassed(state);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: Text(item.title),
                        value: item.isPassed,
                        onChanged: (value) {
                          ref.read(checklistProvider.notifier).updateChecklistItem(
                            itemId: item.id,
                            isPassed: value ?? false,
                            notes: item.notes,
                          );
                        },
                      ),

                      if (item.notes != null &&
                          item.notes!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Note: ${item.notes}',
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () {
                            _showNotesDialog(item);
                          },
                          icon: const Icon(Icons.note_add),
                          label: Text(
                            item.notes == null ||
                                item.notes!.isEmpty
                                ? 'Add Note'
                                : 'Edit Note',
                          ),
                        ),
                      ),
                      Align(
                      alignment: Alignment.centerRight,
              child: TextButton.icon(
              onPressed:  () {
              _addEvidence(item);
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Add Evidence'),
              ),
              ),
                      ...evidenceState.evidence
                          .where(
                            (evidence) =>
                        evidence.checklistItemId == item.id,
                      )
                          .map(
                            (evidence) => Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                         ),

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
                                  _fileName(evidence.imagePath),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (evidence.description != null &&
                                        evidence.description!.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(evidence.description!),
                                      ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Added: ${evidence.createdAt}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  tooltip: 'Delete Evidence',
                                  onPressed: () {
                                    _confirmDeleteEvidence(evidence.id);
                                  },
                                ),
                              ),

                            ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),


        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: isCompleted
                ? const Text(
              'Completed inspection — checklist changes are saved automatically.',
              textAlign: TextAlign.center,
            )
                : ElevatedButton(
              onPressed: allItemsPassed
                  ? () async {
                await ref
                    .read(inspectionProvider.notifier)
                    .completeInspection(widget.inspectionId);

                if (!mounted) return;

                final currentState =
                ref.read(inspectionProvider);

                if (currentState.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(currentState.error!),
                    ),
                  );
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Inspection completed successfully!',
                    ),
                  ),
                );

                Navigator.pop(context);
              }
                  : null,
              child: const Text('Complete Inspection'),
            ),
          ),
        ),

      ],
    );
  }
}