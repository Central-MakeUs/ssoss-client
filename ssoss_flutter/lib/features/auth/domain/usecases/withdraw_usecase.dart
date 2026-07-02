import '../repositories/auth_repository.dart';

/// 회원 탈퇴(소셜 연동 해제) 유스케이스.
class WithdrawUseCase {
  const WithdrawUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.withdraw();
}
