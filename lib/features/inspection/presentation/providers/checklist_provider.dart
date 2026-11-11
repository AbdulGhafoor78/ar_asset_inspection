
import 'package:flutter_riverpod/flutter_riverpod.dart';



import '../../data/repositories/inspection_checklist_repository_impl.dart';
import '../../domain/repositories/inspection_checklist_repository.dart';
import '../../domain/usecases/get_checklist_items_usecase.dart';
import '../../domain/usecases/update_checklist_item_usecase.dart';
import 'inspection_provider.dart';

final inspectionChecklistRepositoryProvider =
Provider<InspectionChecklistRepository>((ref) {
  return InspectionChecklistRepositoryImpl(
    ref.watch(appDatabaseProvider),
  );
});

final getChecklistItemsUseCaseProvider =
Provider<GetChecklistItemsUseCase>((ref) {
  final repository = ref.watch(inspectionChecklistRepositoryProvider);
  return GetChecklistItemsUseCase(repository);
});

final updateChecklistItemUseCaseProvider =
Provider<UpdateChecklistItemUseCase>((ref) {
  final repository = ref.watch(inspectionChecklistRepositoryProvider);
  return UpdateChecklistItemUseCase(repository);
});
