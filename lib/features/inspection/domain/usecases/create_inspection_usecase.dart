import '../entities/inspection.dart';
import '../repositories/inspection_repository.dart';

class CreateInspectionUseCase {
  final InspectionRepository repository;

  CreateInspectionUseCase(this.repository);

  Future<Inspection> call({
    required int assetId,
    required String engineerId,
  }) {
    return repository.createInspection(
      assetId: assetId,
      engineerId: engineerId,
    );
  }
}