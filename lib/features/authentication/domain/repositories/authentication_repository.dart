import '../entities/engineer.dart';

abstract class AuthenticationRepository {
  Future<Engineer> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<Engineer?> getCurrentUser();
}