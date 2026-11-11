import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'authentication_provider.dart';
import 'authentication_state.dart';

class AuthenticationNotifier extends Notifier<AuthenticationState> {
  late final LoginUseCase _loginUseCase;
  late final GetCurrentUserUseCase _getCurrentUserUseCase;
  late final LogoutUseCase _logoutUseCase;

  @override
  AuthenticationState build() {
    _loginUseCase = ref.read(loginUseCaseProvider);
    _logoutUseCase = ref.read(logoutUseCaseProvider);
    _getCurrentUserUseCase =
        ref.read(getCurrentUserUseCaseProvider);

    return const AuthenticationState();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final engineer = await _loginUseCase(
        email: email,
        password: password,
      );

      state = state.copyWith(
        isLoading: false,
        engineer: engineer,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      await _logoutUseCase();

      state = state.copyWith(
        isLoading: false,
        clearEngineer: true,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> checkAuthStatus() async {
    state = state.copyWith(
      isCheckingAuth: true,
      error: null,
    );

    try {
      final engineer = await _getCurrentUserUseCase();

      state = state.copyWith(
        isCheckingAuth: false,
        engineer: engineer,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isCheckingAuth: false,
        error: e.toString(),
      );
    }
  }
}

final authenticationProvider =
NotifierProvider<AuthenticationNotifier, AuthenticationState>(
  AuthenticationNotifier.new,
);