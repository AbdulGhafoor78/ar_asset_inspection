
import '../repositories/asset_repository.dart';

class CreateAssetUseCase {
  final AssetRepository repository;

  CreateAssetUseCase(this.repository);

  Future<void> call({
    required String name,
    required String assetCode,
    required String location,
    required String status,
  }) {
    return repository.createAsset(
      name: name,
      assetCode: assetCode,
      location: location,
      status: status,
    );
  }
}
