import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/add_inspection_evidence_usecase.dart';
import '../../domain/usecases/delete_inspection_evidence_usecase.dart';
import '../../domain/usecases/get_inspection_evidence_usecase.dart';
import 'evidence_provider.dart';
import 'evidence_state.dart';

class EvidenceNotifier extends Notifier<EvidenceState> {
  late final GetInspectionEvidenceUseCase
  _getInspectionEvidenceUseCase;

  late final AddInspectionEvidenceUseCase
  _addInspectionEvidenceUseCase;

  late final DeleteInspectionEvidenceUseCase
  _deleteInspectionEvidenceUseCase;

  @override
  EvidenceState build() {
    _getInspectionEvidenceUseCase =
        ref.read(getInspectionEvidenceUseCaseProvider);

    _addInspectionEvidenceUseCase =
        ref.read(addInspectionEvidenceUseCaseProvider);

    _deleteInspectionEvidenceUseCase =
        ref.read(deleteInspectionEvidenceUseCaseProvider);

    return const EvidenceState();
  }

  Future<void> getEvidence(int inspectionId) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final evidence =
      await _getInspectionEvidenceUseCase(inspectionId);

      state = state.copyWith(
        isLoading: false,
        evidence: evidence,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> addEvidence({
    required int inspectionId,
    required int checklistItemId,
    required String imagePath,
    List<int>? imageBytes,
    String? description,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final evidence = await _addInspectionEvidenceUseCase(
        inspectionId: inspectionId,
        checklistItemId: checklistItemId,
        imagePath: imagePath,
        imageBytes: imageBytes,
        description: description,
      );

      state = state.copyWith(
        isLoading: false,
        evidence: [
          ...state.evidence,
          evidence,
        ],
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> deleteEvidence(int id) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      await _deleteInspectionEvidenceUseCase(id);

      final updatedEvidence = state.evidence
          .where(
            (evidence) => evidence.id != id,
      )
          .toList();

      state = state.copyWith(
        isLoading: false,
        evidence: updatedEvidence,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final evidenceProvider =
NotifierProvider<EvidenceNotifier, EvidenceState>(
  EvidenceNotifier.new,
);