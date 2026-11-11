import 'package:ar_asset_inspection/features/authentication/presentation/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/authentication_notifier.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(authenticationProvider.notifier)
          .checkAuthStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authenticationProvider);

    if (authState.isCheckingAuth) {
      return const SplashScreen();
    }

    if (authState.engineer != null) {
      return const DashboardScreen();
    }

    return const LoginScreen();
  }
}