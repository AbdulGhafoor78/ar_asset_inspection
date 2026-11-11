import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/complete_inspection_usecase.dart';
import '../../domain/usecases/create_inspection_usecase.dart';
import '../../domain/usecases/get_inspection_by_id_usecase.dart';
import '../../domain/usecases/get_inspections_usecase.dart';
import 'inspection_provider.dart';
import 'inspection_state.dart';

class InspectionNotifier extends Notifier<InspectionState> {
  late final GetInspectionsUseCase _getInspectionsUseCase;
  late final GetInspectionByIdUseCase _getInspectionByIdUseCase;
  late final CreateInspectionUseCase _createInspectionUseCase;
  late final CompleteInspectionUseCase _completeInspectionUseCase;

  @override
  InspectionState build() {
    _getInspectionsUseCase =
        ref.read(getInspectionsUseCaseProvider);

    _getInspectionByIdUseCase =
        ref.read(getInspectionByIdUseCaseProvider);

    _createInspectionUseCase =
        ref.read(createInspectionUseCaseProvider);
    _completeInspectionUseCase =
        ref.read(completeInspectionUseCaseProvider);

    return const InspectionState();
  }

  Future<void> getInspections() async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final inspections = await _getInspectionsUseCase();

      state = state.copyWith(
        isLoading: false,
        inspections: inspections,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> getInspectionById(int id) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final inspection =
      await _getInspectionByIdUseCase(id);

      state = state.copyWith(
        isLoading: false,
        selectedInspection: inspection,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> createInspection({
    required int assetId,
    required String engineerId,
  }) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final inspection = await _createInspectionUseCase(
        assetId: assetId,
        engineerId: engineerId,
      );

      state = state.copyWith(
        isLoading: false,
        createdInspection: inspection,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
  Future<void> completeInspection(int id) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final inspection =
      await _completeInspectionUseCase(id);

      final updatedInspections = state.inspections.map((item) {
        if (item.id == inspection.id) {
          return inspection;
        }

        return item;
      }).toList();

      state = state.copyWith(
        isLoading: false,
        selectedInspection: inspection,
        inspections: updatedInspections,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final inspectionProvider =
NotifierProvider<InspectionNotifier, InspectionState>(
  InspectionNotifier.new,
);