import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// Apple 로그인 유스케이스.
class LoginWithAppleUseCase {
  const LoginWithAppleUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call() => _repository.loginWithApple();
}
