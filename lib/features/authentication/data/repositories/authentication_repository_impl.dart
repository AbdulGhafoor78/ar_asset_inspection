import '../../domain/entities/engineer.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl
    implements AuthenticationRepository {

  Engineer? _currentUser;

  @override
  Future<Engineer> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    const engineer = Engineer(
      id: 1,
      name: 'Abdul Ghafoor',
      email: 'abdul@example.com',
      role: 'Maintenance Engineer',
    );

    _currentUser = engineer;

    return engineer;
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
  }

  @override
  Future<Engineer?> getCurrentUser() async {
    await Future.delayed(const Duration(seconds: 3));
    return _currentUser;
  }
}