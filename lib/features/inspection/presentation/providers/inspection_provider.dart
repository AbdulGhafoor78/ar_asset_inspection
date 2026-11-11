
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';

import '../../data/repositories/inspection_repository_impl.dart';
import '../../domain/repositories/inspection_repository.dart';
import '../../domain/usecases/complete_inspection_usecase.dart';
import '../../domain/usecases/create_inspection_usecase.dart';
import '../../domain/usecases/get_inspection_by_id_usecase.dart';
import '../../domain/usecases/get_inspections_usecase.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(() => database.close());
  return database;
});

final inspectionRepositoryProvider = Provider<InspectionRepository>((ref) {
  return InspectionRepositoryImpl(ref.watch(appDatabaseProvider));
});

final getInspectionsUseCaseProvider = Provider<GetInspectionsUseCase>((ref) {
  return GetInspectionsUseCase(ref.watch(inspectionRepositoryProvider));
});

final getInspectionByIdUseCaseProvider =
Provider<GetInspectionByIdUseCase>((ref) {
  return GetInspectionByIdUseCase(ref.watch(inspectionRepositoryProvider));
});

final createInspectionUseCaseProvider = Provider<CreateInspectionUseCase>((ref) {
  return CreateInspectionUseCase(ref.watch(inspectionRepositoryProvider));
});

final completeInspectionUseCaseProvider =
Provider<CompleteInspectionUseCase>((ref) {
  return CompleteInspectionUseCase(ref.watch(inspectionRepositoryProvider));
});