import '../entities/ar_inspection.dart';
import '../entities/ar_inspection_result.dart';

abstract class ArInspectionRepository {
  Future<List<ArInspection>> getArInspections();

  Future<ArInspection> getArInspectionById(int id);

  Future<ArInspection> startArInspection(int id);
  Future<ArInspection> linkRegularInspection({
    required int arInspectionId,
    required int inspectionId,
  });

  Future<ArInspection> completeArInspection(int id);

  Future<ArInspectionResult> saveInspectionResult(
      int arInspectionId,
      String inspectionPoint,
      bool isPassed,
      );

  Future<List<ArInspectionResult>> getInspectionResults(
      int arInspectionId,
      );
}