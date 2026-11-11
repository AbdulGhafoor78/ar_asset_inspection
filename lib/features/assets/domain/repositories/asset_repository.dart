
import '../entities/asset.dart';

abstract class AssetRepository {
  Future<List<Asset>> getAssets();

  Future<Asset> getAssetById(int id);
  Future<void> deleteAsset(int id);

  Future<Asset> createAsset({
    required String name,
    required String assetCode,
    required String location,
    required String status,
  });

  Future<Asset> updateAsset({
    required int id,
    required String name,
    required String assetCode,
    required String location,
    required String status,
  });
}
