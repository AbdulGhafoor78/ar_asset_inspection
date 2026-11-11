import '../repositories/asset_repository.dart';

class DeleteAssetUseCase {
  final AssetRepository repository;

  DeleteAssetUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deleteAsset(id);
  }
}