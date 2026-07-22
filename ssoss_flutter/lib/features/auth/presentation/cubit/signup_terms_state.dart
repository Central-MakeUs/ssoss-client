class SignupTermsState {
  const SignupTermsState({
    this.agreeAll = false,
    this.age14 = false,
    this.serviceTerms = false,
    this.privacyPolicy = false,
    this.isSubmitting = false,
  });

  final bool agreeAll;
  final bool age14;
  final bool serviceTerms;
  final bool privacyPolicy;
  final bool isSubmitting;

  bool get canSubmit => age14 && serviceTerms && privacyPolicy && !isSubmitting;

  SignupTermsState copyWith({
    bool? agreeAll,
    bool? age14,
    bool? serviceTerms,
    bool? privacyPolicy,
    bool? isSubmitting,
  }) {
    return SignupTermsState(
      agreeAll: agreeAll ?? this.agreeAll,
      age14: age14 ?? this.age14,
      serviceTerms: serviceTerms ?? this.serviceTerms,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
