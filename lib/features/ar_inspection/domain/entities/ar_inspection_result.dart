class ArInspectionResult {
  final int id;
  final int arInspectionId;
  final String inspectionPoint;
  final bool isPassed;

  const ArInspectionResult({
    required this.id,
    required this.arInspectionId,
    required this.inspectionPoint,
    required this.isPassed,
  });
}