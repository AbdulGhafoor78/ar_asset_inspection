import '../../domain/entities/engineer.dart';

class AuthenticationState {
  final bool isLoading;
  final bool isCheckingAuth;
  final Engineer? engineer;
  final String? error;

  const AuthenticationState({
    this.isLoading = false,
    this.isCheckingAuth = false,
    this.engineer,
    this.error,
  });

  AuthenticationState copyWith({
    bool? isLoading,
    bool? isCheckingAuth,
    Engineer? engineer,
    bool clearEngineer = false,
    String? error,
  }) {
    return AuthenticationState(
      isLoading: isLoading ?? this.isLoading,
      isCheckingAuth: isCheckingAuth ?? this.isCheckingAuth,
      engineer: clearEngineer ? null : engineer ?? this.engineer,
      error: error,
    );
  }
}