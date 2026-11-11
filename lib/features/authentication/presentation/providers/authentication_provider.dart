import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/authentication_repository_impl.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

final authenticationRepositoryProvider =
Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepositoryImpl();
});

final loginUseCaseProvider =
Provider<LoginUseCase>((ref) {
  final repository = ref.read(authenticationRepositoryProvider);

  return LoginUseCase(repository);
});
final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.read(authenticationRepositoryProvider);

  return LogoutUseCase(repository);
});

final getCurrentUserUseCaseProvider =
Provider<GetCurrentUserUseCase>((ref) {
  final repository = ref.read(authenticationRepositoryProvider);

  return GetCurrentUserUseCase(repository);
});