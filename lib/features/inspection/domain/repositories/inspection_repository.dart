import '../entities/inspection.dart';

abstract class InspectionRepository {
  Future<List<Inspection>> getInspections();

  Future<Inspection> getInspectionById(int id);

  Future<Inspection> createInspection({
    required int assetId,
    required String engineerId,
  });

  Future<Inspection> completeInspection(int id);
}