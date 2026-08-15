/// 회원가입 약관 동의.
class SignupAgreement {
  const SignupAgreement({
    required this.ageOver14Agreed,
    required this.serviceTermsAgreed,
    required this.privacyPolicyAgreed,
  });

  final bool ageOver14Agreed;
  final bool serviceTermsAgreed;
  final bool privacyPolicyAgreed;
}
