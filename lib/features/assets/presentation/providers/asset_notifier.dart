
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/create_asset_usecase.dart';
import '../../domain/usecases/get_asset_by_id_usecase.dart';
import '../../domain/usecases/get_assets_usecase.dart';
import '../../domain/usecases/update_asset_usecase.dart';
import '../../domain/usecases/delete_asset_usecase.dart';
import 'asset_provider.dart';
import 'asset_state.dart';

class AssetNotifier extends Notifier<AssetState> {
  late final GetAssetsUseCase _getAssetsUseCase;
  late final GetAssetByIdUseCase _getAssetByIdUseCase;
  late final CreateAssetUseCase _createAssetUseCase;
  late final UpdateAssetUseCase _updateAssetUseCase;
  late final DeleteAssetUseCase _deleteAssetUseCase;

  @override
  AssetState build() {
    _getAssetsUseCase = ref.read(getAssetsUseCaseProvider);
    _getAssetByIdUseCase = ref.read(getAssetByIdUseCaseProvider);
    _createAssetUseCase = ref.read(createAssetUseCaseProvider);
    _updateAssetUseCase = ref.read(updateAssetUseCaseProvider);
    _deleteAssetUseCase = ref.read(deleteAssetUseCaseProvider);

    return const AssetState();
  }

  Future<void> getAssets() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final assets = await _getAssetsUseCase();

      state = state.copyWith(
        isLoading: false,
        assets: assets,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> getAssetById(int id) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final asset = await _getAssetByIdUseCase(id);

      state = state.copyWith(
        isLoading: false,
        selectedAsset: asset,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> createAsset({
    required String name,
    required String assetCode,
    required String location,
    required String status,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      await _createAssetUseCase(
        name: name,
        assetCode: assetCode,
        location: location,
        status: status,
      );

      final assets = await _getAssetsUseCase();

      state = state.copyWith(
        isLoading: false,
        assets: assets,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );

      rethrow;
    }
  }

  Future<void> updateAsset({
    required int id,
    required String name,
    required String assetCode,
    required String location,
    required String status,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final updatedAsset = await _updateAssetUseCase(
        id: id,
        name: name,
        assetCode: assetCode,
        location: location,
        status: status,
      );

      final assets = await _getAssetsUseCase();

      state = state.copyWith(
        isLoading: false,
        assets: assets,
        selectedAsset: updatedAsset,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );

      rethrow;
    }
  }
  Future<void> deleteAsset(int id) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      await _deleteAssetUseCase(id);

      final assets = await _getAssetsUseCase();

      state = state.copyWith(
        isLoading: false,
        assets: assets,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );

      rethrow;
    }
  }
}

final assetProvider =
NotifierProvider<AssetNotifier, AssetState>(
  AssetNotifier.new,
);
