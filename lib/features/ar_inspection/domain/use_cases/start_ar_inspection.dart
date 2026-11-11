


import '../../../inspection/domain/usecases/create_inspection_usecase.dart';
import '../entities/ar_inspection.dart';
import '../repositories/ar_inspection_repository.dart';

class StartArInspection {
  final ArInspectionRepository repository;
  final CreateInspectionUseCase createInspectionUseCase;

  StartArInspection(
      this.repository,
      this.createInspectionUseCase,
      );

  Future<ArInspection> call(
      int id, {
        required String engineerId,
      }) async {
    var arInspection = await repository.getArInspectionById(id);

    // Create and link a regular inspection only once.
    if (arInspection.inspectionId == null) {
      final regularInspection = await createInspectionUseCase(
        assetId: arInspection.assetId,
        engineerId: engineerId,
      );

      arInspection = await repository.linkRegularInspection(
        arInspectionId: id,
        inspectionId: regularInspection.id,
      );
    }

    return repository.startArInspection(id);
  }
}
