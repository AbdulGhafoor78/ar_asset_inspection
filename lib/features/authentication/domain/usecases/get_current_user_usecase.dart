import '../entities/engineer.dart';
import '../repositories/authentication_repository.dart';

class GetCurrentUserUseCase {
  final AuthenticationRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Engineer?> call() {
    return repository.getCurrentUser();
  }
}