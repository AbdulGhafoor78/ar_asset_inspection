import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/presentation/providers/authentication_notifier.dart';

import '../../../inspection/presentation/providers/inspection_provider.dart';
import '../../data/repositories/ar_inspection_repository_impl.dart';
import '../../domain/entities/ar_inspection_result.dart';
import '../../domain/repositories/ar_inspection_repository.dart';
import '../../domain/use_cases/complete_ar_inspection.dart';
import '../../domain/use_cases/get_ar_inspection_by_id.dart';
import '../../domain/use_cases/get_ar_inspection_results.dart';
import '../../domain/use_cases/get_ar_inspections.dart';
import '../../domain/use_cases/save_ar_inspection_result.dart';
import '../../domain/use_cases/start_ar_inspection.dart';
import 'ar_inspection_state.dart';

final arInspectionRepositoryProvider =
Provider<ArInspectionRepository>((ref) {
  return ArInspectionRepositoryImpl(
    ref.read(appDatabaseProvider),
  );
});

final getArInspectionsProvider =
Provider<GetArInspections>((ref) {
  return GetArInspections(
    ref.read(arInspectionRepositoryProvider),
  );
});

final completeArInspectionProvider =
Provider<CompleteArInspection>((ref) {
  return CompleteArInspection(
    ref.read(arInspectionRepositoryProvider),
  );
});

final getArInspectionByIdProvider =
Provider<GetArInspectionById>((ref) {
  return GetArInspectionById(
    ref.read(arInspectionRepositoryProvider),
  );
});

final startArInspectionProvider =
Provider<StartArInspection>((ref) {
  return StartArInspection(
    ref.read(arInspectionRepositoryProvider),
    ref.read(createInspectionUseCaseProvider),
  );
});

final saveArInspectionResultProvider =
Provider<SaveArInspectionResult>((ref) {
  return SaveArInspectionResult(
    ref.read(arInspectionRepositoryProvider),
  );
});

final getArInspectionResultsProvider =
Provider<GetArInspectionResults>((ref) {
  return GetArInspectionResults(
    ref.read(arInspectionRepositoryProvider),
  );
});

class ArInspectionNotifier
    extends Notifier<ArInspectionState> {
  @override
  ArInspectionState build() {
    return const ArInspectionState();
  }

  Future<void> loadArInspections() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final inspections = await ref
          .read(getArInspectionsProvider)
          .call();

      state = state.copyWith(
        isLoading: false,
        inspections: inspections,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> getArInspectionById(int id) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final inspection = await ref
          .read(getArInspectionByIdProvider)
          .call(id);

      state = state.copyWith(
        isLoading: false,
        selectedInspection: inspection,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> startInspection(int id) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final engineer = ref.read(authenticationProvider).engineer;

      if (engineer == null) {
        throw Exception(
          'Please log in before starting an AR inspection.',
        );
      }

      final inspection = await ref
          .read(startArInspectionProvider)
          .call(
        id,
        engineerId: engineer.id.toString(),
      );

      final updatedInspections = state.inspections.map((item) {
        if (item.id == inspection.id) {
          return inspection;
        }

        return item;
      }).toList();

      state = state.copyWith(
        isLoading: false,
        inspections: updatedInspections,
        startedInspection: inspection,
        selectedInspection: inspection,
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
      error: null,
    );

    try {
      final inspection = await ref
          .read(completeArInspectionProvider)
          .call(id);

      final updatedInspections = state.inspections.map((item) {
        if (item.id == inspection.id) {
          return inspection;
        }

        return item;
      }).toList();

      state = state.copyWith(
        isLoading: false,
        inspections: updatedInspections,
        startedInspection: inspection,
        selectedInspection: inspection,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<ArInspectionResult?> saveInspectionResult({
    required int arInspectionId,
    required String inspectionPoint,
    required bool isPassed,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final result = await ref
          .read(saveArInspectionResultProvider)
          .call(
        arInspectionId,
        inspectionPoint,
        isPassed,
      );

      state = state.copyWith(
        isLoading: false,
      );

      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );

      return null;
    }
  }

  Future<void> loadInspectionResults(
      int arInspectionId,
      ) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final results = await ref
          .read(getArInspectionResultsProvider)
          .call(arInspectionId);

      state = state.copyWith(
        isLoading: false,
        inspectionResults: results,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final arInspectionProvider =
NotifierProvider<
    ArInspectionNotifier,
    ArInspectionState
>(
  ArInspectionNotifier.new,
);