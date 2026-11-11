
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/asset.dart';
import '../providers/asset_notifier.dart';

class EditAssetScreen extends ConsumerStatefulWidget {
  final Asset asset;

  const EditAssetScreen({
    super.key,
    required this.asset,
  });

  @override
  ConsumerState<EditAssetScreen> createState() =>
      _EditAssetScreenState();
}

class _EditAssetScreenState
    extends ConsumerState<EditAssetScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _assetCodeController;
  late final TextEditingController _locationController;
  late final TextEditingController _statusController;

  @override
  void initState() {
    super.initState();

    _nameController =
        TextEditingController(text: widget.asset.name);

    _assetCodeController =
        TextEditingController(text: widget.asset.assetCode);

    _locationController =
        TextEditingController(text: widget.asset.location);

    _statusController =
        TextEditingController(text: widget.asset.status);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _assetCodeController.dispose();
    _locationController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  Future<void> _updateAsset() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await ref.read(assetProvider.notifier).updateAsset(
        id: widget.asset.id,
        name: _nameController.text.trim(),
        assetCode: _assetCodeController.text.trim(),
        location: _locationController.text.trim(),
        status: _statusController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Asset updated successfully!'),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update asset: $e'),
        ),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final assetState = ref.watch(assetProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Asset'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Update Asset Information',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              _buildTextField(
                controller: _nameController,
                label: 'Asset Name',
                hint: 'Enter asset name',
                icon: Icons.precision_manufacturing,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _assetCodeController,
                label: 'Asset Code',
                hint: 'Enter asset code',
                icon: Icons.qr_code,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _locationController,
                label: 'Location',
                hint: 'Enter asset location',
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _statusController,
                label: 'Status',
                hint: 'Enter asset status',
                icon: Icons.info_outline,
              ),
              const SizedBox(height: 28),

              ElevatedButton.icon(
                onPressed:
                assetState.isLoading ? null : _updateAsset,
                icon: assetState.isLoading
                    ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
                    : const Icon(Icons.save),
                label: Text(
                  assetState.isLoading
                      ? 'Updating...'
                      : 'Update Asset',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
