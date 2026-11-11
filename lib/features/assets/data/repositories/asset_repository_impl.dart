
import '../../domain/entities/asset.dart';
import '../../domain/repositories/asset_repository.dart';
import '../datasources/asset_remote_data_source.dart';

class AssetRepositoryImpl implements AssetRepository {
  final AssetRemoteDataSource remoteDataSource;

  AssetRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Asset>> getAssets() async {
    return await remoteDataSource.getAssets();
  }

  @override
  Future<Asset> getAssetById(int id) async {
    return await remoteDataSource.getAssetById(id);
  }

  @override
  Future<Asset> createAsset({
    required String name,
    required String assetCode,
    required String location,
    required String status,
  }) async {
    return await remoteDataSource.createAsset(
      name: name,
      assetCode: assetCode,
      location: location,
      status: status,
    );
  }

  @override
  Future<Asset> updateAsset({
    required int id,
    required String name,
    required String assetCode,
    required String location,
    required String status,
  }) async {
    return await remoteDataSource.updateAsset(
      id: id,
      name: name,
      assetCode: assetCode,
      location: location,
      status: status,
    );
  }
  @override
  Future<void> deleteAsset(int id) async {
    return await remoteDataSource.deleteAsset(id);
  }
}


