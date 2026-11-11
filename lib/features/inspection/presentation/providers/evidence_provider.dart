
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/inspection_evidence_repository_impl.dart';
import '../../domain/repositories/inspection_evidence_repository.dart';
import '../../domain/usecases/add_inspection_evidence_usecase.dart';
import '../../domain/usecases/delete_inspection_evidence_usecase.dart';
import '../../domain/usecases/get_inspection_evidence_usecase.dart';
import 'inspection_provider.dart';

final inspectionEvidenceRepositoryProvider =
Provider<InspectionEvidenceRepository>((ref) {
  return InspectionEvidenceRepositoryImpl(
    ref.read(appDatabaseProvider),
  );
});

final getInspectionEvidenceUseCaseProvider =
Provider<GetInspectionEvidenceUseCase>((ref) {
  final repository =
  ref.read(inspectionEvidenceRepositoryProvider);

  return GetInspectionEvidenceUseCase(repository);
});

final addInspectionEvidenceUseCaseProvider =
Provider<AddInspectionEvidenceUseCase>((ref) {
  final repository =
  ref.read(inspectionEvidenceRepositoryProvider);

  return AddInspectionEvidenceUseCase(repository);
});

final deleteInspectionEvidenceUseCaseProvider =
Provider<DeleteInspectionEvidenceUseCase>((ref) {
  final repository =
  ref.read(inspectionEvidenceRepositoryProvider);

  return DeleteInspectionEvidenceUseCase(repository);
});
