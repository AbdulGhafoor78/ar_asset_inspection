import 'package:flutter/material.dart';

import '../../domain/entities/inspection.dart';
import 'checklist_screen.dart';

class InspectionScreen extends StatelessWidget {
  final Inspection inspection;

  const InspectionScreen({
    super.key,
    required this.inspection,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inspection ID: ${inspection.id}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Asset ID: ${inspection.assetId}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 8),

            Text(
              'Engineer ID: ${inspection.engineerId}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 8),

            Text(
              'Status: ${inspection.status}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 8),

            Text(
              'Date: ${inspection.inspectionDate}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChecklistScreen(
                        inspectionId: inspection.id,
                      ),
                    ),
                  );
                },
                child: const Text('Start Checklist'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}