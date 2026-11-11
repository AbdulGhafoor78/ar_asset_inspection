import '../entities/asset.dart';
import '../repositories/asset_repository.dart';

class GetAssetsUseCase {
  final AssetRepository repository;

  GetAssetsUseCase(this.repository);

  Future<List<Asset>> call() {
    return repository.getAssets();
  }
}