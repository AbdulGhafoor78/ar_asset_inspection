
import '../repositories/asset_repository.dart';
import '../entities/asset.dart';

class UpdateAssetUseCase {
  final AssetRepository repository;

  UpdateAssetUseCase(this.repository);

  Future<Asset> call({
    required int id,
    required String name,
    required String assetCode,
    required String location,
    required String status,
  }) {
    return repository.updateAsset(
      id: id,
      name: name,
      assetCode: assetCode,
      location: location,
      status: status,
    );
  }
}
