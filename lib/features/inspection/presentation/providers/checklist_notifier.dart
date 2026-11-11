import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_checklist_items_usecase.dart';
import '../../domain/usecases/update_checklist_item_usecase.dart';
import 'checklist_provider.dart';
import 'checklist_state.dart';

class ChecklistNotifier extends Notifier<ChecklistState> {
  late final GetChecklistItemsUseCase _getChecklistItemsUseCase;
  late final UpdateChecklistItemUseCase _updateChecklistItemUseCase;

  @override
  ChecklistState build() {
    _getChecklistItemsUseCase =
        ref.read(getChecklistItemsUseCaseProvider);

    _updateChecklistItemUseCase =
        ref.read(updateChecklistItemUseCaseProvider);

    return const ChecklistState();
  }

  Future<void> getChecklistItems(int inspectionId) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final items = await _getChecklistItemsUseCase(
        inspectionId,
      );

      state = state.copyWith(
        isLoading: false,
        items: items,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> updateChecklistItem({
    required int itemId,
    required bool isPassed,
    String? notes,
  }) async {
    try {
      final updatedItem =
      await _updateChecklistItemUseCase(
        itemId: itemId,
        isPassed: isPassed,
        notes: notes,
      );

      final updatedItems = state.items.map((item) {
        if (item.id == updatedItem.id) {
          return updatedItem;
        }

        return item;
      }).toList();

      state = state.copyWith(
        items: updatedItems,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
      );
    }
  }
}

final checklistProvider =
NotifierProvider<ChecklistNotifier, ChecklistState>(
  ChecklistNotifier.new,
);