import '../entities/auth_session.dart';
import '../entities/signup_agreement.dart';
import '../repositories/auth_repository.dart';

/// 회원가입 유스케이스.
class SignupUseCase {
  const SignupUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call(SignupAgreement agreement) =>
      _repository.signup(agreement);
}
