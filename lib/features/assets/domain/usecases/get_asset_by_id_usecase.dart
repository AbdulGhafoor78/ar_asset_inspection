import '../entities/asset.dart';
import '../repositories/asset_repository.dart';

class GetAssetByIdUseCase {
  final AssetRepository repository;

  GetAssetByIdUseCase(this.repository);

  Future<Asset> call(int id) {
    return repository.getAssetById(id);
  }
}