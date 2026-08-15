import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// 네이버 로그인 유스케이스.
class LoginWithNaverUseCase {
  const LoginWithNaverUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call() => _repository.loginWithNaver();
}
