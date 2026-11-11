
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/asset_remote_data_source.dart';
import '../../data/repositories/asset_repository_impl.dart';
import '../../domain/repositories/asset_repository.dart';
import '../../domain/usecases/create_asset_usecase.dart';
import '../../domain/usecases/get_asset_by_id_usecase.dart';
import '../../domain/usecases/get_assets_usecase.dart';
import '../../domain/usecases/update_asset_usecase.dart';
import '../../domain/usecases/delete_asset_usecase.dart';

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();

  ref.onDispose(() {
    client.close();
  });

  return client;
});

final assetRemoteDataSourceProvider =
Provider<AssetRemoteDataSource>((ref) {
  final client = ref.read(httpClientProvider);

  return AssetRemoteDataSource(client);
});

final assetRepositoryProvider = Provider<AssetRepository>((ref) {
  final remoteDataSource = ref.read(assetRemoteDataSourceProvider);

  return AssetRepositoryImpl(remoteDataSource);
});

final getAssetsUseCaseProvider = Provider<GetAssetsUseCase>((ref) {
  final repository = ref.read(assetRepositoryProvider);

  return GetAssetsUseCase(repository);
});

final getAssetByIdUseCaseProvider =
Provider<GetAssetByIdUseCase>((ref) {
  final repository = ref.read(assetRepositoryProvider);

  return GetAssetByIdUseCase(repository);
});

final createAssetUseCaseProvider =
Provider<CreateAssetUseCase>((ref) {
  final repository = ref.read(assetRepositoryProvider);

  return CreateAssetUseCase(repository);
});

final updateAssetUseCaseProvider =
Provider<UpdateAssetUseCase>((ref) {
  final repository = ref.read(assetRepositoryProvider);

  return UpdateAssetUseCase(repository);
});

final deleteAssetUseCaseProvider =
Provider<DeleteAssetUseCase>((ref) {
  final repository = ref.read(assetRepositoryProvider);

  return DeleteAssetUseCase(repository);
});


