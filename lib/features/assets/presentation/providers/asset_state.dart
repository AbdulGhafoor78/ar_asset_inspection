import '../../domain/entities/asset.dart';

class AssetState {
  final bool isLoading;
  final List<Asset> assets;
  final Asset? selectedAsset;
  final String? error;

  const AssetState({
    this.isLoading = false,
    this.assets = const [],
    this.selectedAsset,
    this.error,
  });

  AssetState copyWith({
    bool? isLoading,
    List<Asset>? assets,
    Asset? selectedAsset,
    bool clearSelectedAsset = false,
    String? error,
  }) {
    return AssetState(
      isLoading: isLoading ?? this.isLoading,
      assets: assets ?? this.assets,
      selectedAsset: clearSelectedAsset
          ? null
          : selectedAsset ?? this.selectedAsset,
      error: error,
    );
  }
}