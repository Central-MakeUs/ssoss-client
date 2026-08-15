import '../repositories/auth_repository.dart';

/// 로그아웃 유스케이스.
class LogoutUseCase {
  const LogoutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.logout();
}
