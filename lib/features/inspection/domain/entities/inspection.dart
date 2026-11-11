class Inspection {
  final int id;
  final int assetId;
  final String engineerId;
  final String status;
  final DateTime inspectionDate;

  const Inspection({
    required this.id,
    required this.assetId,
    required this.engineerId,
    required this.status,
    required this.inspectionDate,
  });
}