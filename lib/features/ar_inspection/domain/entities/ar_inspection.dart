
class ArInspection {
  final int id;
  final int assetId;
  final int? inspectionId;
  final String assetName;
  final String assetCode;
  final bool isArAvailable;
  final String status;
  final String? resultSummary;

  const ArInspection({
    required this.id,
    required this.assetId,
    this.inspectionId,
    required this.assetName,
    required this.assetCode,
    required this.isArAvailable,
    required this.status,
    this.resultSummary,
  });
}
