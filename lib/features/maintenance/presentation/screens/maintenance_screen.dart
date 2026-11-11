import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/maintenance_provider.dart';

class MaintenanceScreen extends ConsumerStatefulWidget {
  final int inspectionId;

  const MaintenanceScreen({
    super.key,
    required this.inspectionId,
  });

  @override
  ConsumerState<MaintenanceScreen> createState() =>
      _MaintenanceScreenState();
}

class _MaintenanceScreenState
    extends ConsumerState<MaintenanceScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(maintenanceProvider.notifier)
          .loadMaintenanceRecords(widget.inspectionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(maintenanceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance Management'),
      ),
      body: state.isLoading && state.records.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : state.error != null && state.records.isEmpty
          ? Center(
        child: Text(
          state.error!,
          style: const TextStyle(color: Colors.red),
        ),
      )
          : state.records.isEmpty
          ? const Center(
        child: Text(
          'No maintenance records found.',
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.records.length,
        itemBuilder: (context, index) {
          final record = state.records[index];

          return Card(
            margin: const EdgeInsets.only(
              bottom: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          record.issue,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildPriorityChip(
                        record.priority,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(record.description),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text(
                        'Status: ',
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                      _buildStatusChip(
                        record.status,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Created: ${_formatDate(record.createdAt)}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  if (record.completedAt != null)
                    Text(
                      'Completed: ${_formatDate(record.completedAt!)}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  const SizedBox(height: 12),
                  if (record.status != 'Completed')
                    Align(
                      alignment:
                      Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          _showStatusDialog(
                            record.id,
                            record.status,
                          );
                        },
                        child: const Text(
                          'Update Status',
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateMaintenanceDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPriorityChip(String priority) {
    return Chip(
      label: Text(priority),
    );
  }

  Widget _buildStatusChip(String status) {
    return Chip(
      label: Text(status),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  void _showCreateMaintenanceDialog() {
    final issueController = TextEditingController();
    final descriptionController = TextEditingController();

    String priority = 'Medium';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Create Maintenance Record'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: issueController,
                      decoration: const InputDecoration(
                        labelText: 'Issue',
                        hintText: 'Enter maintenance issue',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText:
                        'Describe the maintenance issue',
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: priority,
                      decoration: const InputDecoration(
                        labelText: 'Priority',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Low',
                          child: Text('Low'),
                        ),
                        DropdownMenuItem(
                          value: 'Medium',
                          child: Text('Medium'),
                        ),
                        DropdownMenuItem(
                          value: 'High',
                          child: Text('High'),
                        ),
                        DropdownMenuItem(
                          value: 'Critical',
                          child: Text('Critical'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            priority = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (issueController.text.trim().isEmpty ||
                        descriptionController.text
                            .trim()
                            .isEmpty) {
                      return;
                    }

                    Navigator.pop(dialogContext);

                    await ref
                        .read(maintenanceProvider.notifier)
                        .createRecord(
                      inspectionId: widget.inspectionId,
                      issue: issueController.text.trim(),
                      description:
                      descriptionController.text.trim(),
                      priority: priority,
                    );
                  },
                  child: const Text('Create'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showStatusDialog(int id, String currentStatus) {
    String selectedStatus = currentStatus;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Update Maintenance Status'),
              content: DropdownButtonFormField<String>(
                initialValue: selectedStatus,
                items: const [
                DropdownMenuItem(
                  value: 'Pending',
                  child: Text('Pending'),
                ),
                DropdownMenuItem(
                  value: 'In Progress',
                  child: Text('In Progress'),
                ),
                DropdownMenuItem(
                    value: 'Completed',
                    child: Text('Completed'),)
                    ],
                    onChanged: (value) {
              if (value != null) {
              setDialogState(() {
              selectedStatus = value;
              });
              }
              },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(dialogContext);

                    await ref
                        .read(maintenanceProvider.notifier)
                        .updateStatus(
                      id: id,
                      status: selectedStatus,
                      inspectionId: widget.inspectionId,
                    );
                  },
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}