/// 회원가입 약관 동의.
class SignupAgreement {
  const SignupAgreement({
    required this.serviceTermsAgreed,
    required this.privacyPolicyAgreed,
    required this.marketingAgreed,
  });

  final bool serviceTermsAgreed;
  final bool privacyPolicyAgreed;
  final bool marketingAgreed;
}
