import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/authentication/presentation/screen/auth_gate.dart';


class AssetInspectionApp extends StatelessWidget {
  const AssetInspectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Asset Inspection',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AuthGate(),
    );
  }
}