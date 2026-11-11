
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/asset_model.dart';

class AssetRemoteDataSource {
  final http.Client client;

  AssetRemoteDataSource(this.client);


  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000/api',
  );

  Future<List<AssetModel>> getAssets() async {
    final response = await client.get(
      Uri.parse('$baseUrl/assets'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData =
      jsonDecode(response.body);

      final List<dynamic> assetsJson = responseData['data'];

      return assetsJson
          .map((json) => AssetModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load assets');
    }
  }

  Future<AssetModel> getAssetById(int id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/assets/$id'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData =
      jsonDecode(response.body);

      return AssetModel.fromJson(responseData['data']);
    } else {
      throw Exception('Failed to load asset details');
    }
  }

  Future<AssetModel> createAsset({
    required String name,
    required String assetCode,
    required String location,
    required String status,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/assets'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'assetCode': assetCode,
        'location': location,
        'status': status,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData =
      jsonDecode(response.body);

      return AssetModel.fromJson(responseData['data']);
    } else {
      throw Exception('Failed to create asset: ${response.body}');
    }
  }

  // Update an existing asset
  Future<AssetModel> updateAsset({
    required int id,
    required String name,
    required String assetCode,
    required String location,
    required String status,
  }) async {
    final response = await client.put(
      Uri.parse('$baseUrl/assets/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'assetCode': assetCode,
        'location': location,
        'status': status,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData =
      jsonDecode(response.body);

      return AssetModel.fromJson(responseData['data']);
    } else {
      throw Exception('Failed to update asset: ${response.body}');
    }
  }
  Future<void> deleteAsset(int id) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/assets/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to delete asset: ${response.body}',
      );
    }
  }
}


