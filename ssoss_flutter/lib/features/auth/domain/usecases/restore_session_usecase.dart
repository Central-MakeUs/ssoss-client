import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// 저장된 토큰으로 세션을 복원하는 유스케이스.
class RestoreSessionUseCase {
  const RestoreSessionUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession?> call() => _repository.restoreSession();
}
