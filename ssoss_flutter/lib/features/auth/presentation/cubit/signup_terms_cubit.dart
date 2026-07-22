import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/entities/signup_agreement.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'signup_terms_state.dart';

class SignupTermsCubit extends Cubit<SignupTermsState> {
  SignupTermsCubit(this._signup) : super(const SignupTermsState());

  final SignupUseCase _signup;

  void toggleAgreeAll() {
    final next = !state.agreeAll;
    emit(
      state.copyWith(
        agreeAll: next,
        age14: next,
        serviceTerms: next,
        privacyPolicy: next,
      ),
    );
  }

  void toggleAge14() {
    final next = !state.age14;
    emit(
      _syncAgreeAll(
        state.copyWith(age14: next),
      ),
    );
  }

  void toggleServiceTerms() {
    final next = !state.serviceTerms;
    emit(
      _syncAgreeAll(
        state.copyWith(serviceTerms: next),
      ),
    );
  }

  void togglePrivacyPolicy() {
    final next = !state.privacyPolicy;
    emit(
      _syncAgreeAll(
        state.copyWith(privacyPolicy: next),
      ),
    );
  }

  SignupTermsState _syncAgreeAll(SignupTermsState next) {
    return next.copyWith(
      agreeAll: next.age14 && next.serviceTerms && next.privacyPolicy,
    );
  }

  Future<AuthSession> submit() async {
    if (!state.canSubmit) {
      throw StateError('Required agreements are not accepted.');
    }

    emit(state.copyWith(isSubmitting: true));
    try {
      final session = await _signup(
        SignupAgreement(
          serviceTermsAgreed: state.serviceTerms,
          privacyPolicyAgreed: state.privacyPolicy,
          marketingAgreed: false,
        ),
      );
      emit(state.copyWith(isSubmitting: false));
      return session;
    } on AppException {
      emit(state.copyWith(isSubmitting: false));
      rethrow;
    } catch (_) {
      emit(state.copyWith(isSubmitting: false));
      rethrow;
    }
  }
}
