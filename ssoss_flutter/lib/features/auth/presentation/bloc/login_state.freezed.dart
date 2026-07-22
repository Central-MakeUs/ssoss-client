// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginState()';
  }
}

/// @nodoc
class $LoginStateCopyWith<$Res> {
  $LoginStateCopyWith(LoginState _, $Res Function(LoginState) __);
}

/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginInitial value)? initial,
    TResult Function(LoginRestoring value)? restoring,
    TResult Function(LoginLoading value)? loading,
    TResult Function(LoginPendingSignup value)? pendingSignup,
    TResult Function(LoginAuthenticated value)? authenticated,
    TResult Function(LoginSignupComplete value)? signupComplete,
    TResult Function(LoginSessionExpired value)? sessionExpired,
    TResult Function(LoginUnauthenticated value)? unauthenticated,
    TResult Function(LoginFailure value)? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LoginInitial() when initial != null:
        return initial(_that);
      case LoginRestoring() when restoring != null:
        return restoring(_that);
      case LoginLoading() when loading != null:
        return loading(_that);
      case LoginPendingSignup() when pendingSignup != null:
        return pendingSignup(_that);
      case LoginAuthenticated() when authenticated != null:
        return authenticated(_that);
      case LoginSignupComplete() when signupComplete != null:
        return signupComplete(_that);
      case LoginSessionExpired() when sessionExpired != null:
        return sessionExpired(_that);
      case LoginUnauthenticated() when unauthenticated != null:
        return unauthenticated(_that);
      case LoginFailure() when failure != null:
        return failure(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginInitial value) initial,
    required TResult Function(LoginRestoring value) restoring,
    required TResult Function(LoginLoading value) loading,
    required TResult Function(LoginPendingSignup value) pendingSignup,
    required TResult Function(LoginAuthenticated value) authenticated,
    required TResult Function(LoginSignupComplete value) signupComplete,
    required TResult Function(LoginSessionExpired value) sessionExpired,
    required TResult Function(LoginUnauthenticated value) unauthenticated,
    required TResult Function(LoginFailure value) failure,
  }) {
    final _that = this;
    switch (_that) {
      case LoginInitial():
        return initial(_that);
      case LoginRestoring():
        return restoring(_that);
      case LoginLoading():
        return loading(_that);
      case LoginPendingSignup():
        return pendingSignup(_that);
      case LoginAuthenticated():
        return authenticated(_that);
      case LoginSignupComplete():
        return signupComplete(_that);
      case LoginSessionExpired():
        return sessionExpired(_that);
      case LoginUnauthenticated():
        return unauthenticated(_that);
      case LoginFailure():
        return failure(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginInitial value)? initial,
    TResult? Function(LoginRestoring value)? restoring,
    TResult? Function(LoginLoading value)? loading,
    TResult? Function(LoginPendingSignup value)? pendingSignup,
    TResult? Function(LoginAuthenticated value)? authenticated,
    TResult? Function(LoginSignupComplete value)? signupComplete,
    TResult? Function(LoginSessionExpired value)? sessionExpired,
    TResult? Function(LoginUnauthenticated value)? unauthenticated,
    TResult? Function(LoginFailure value)? failure,
  }) {
    final _that = this;
    switch (_that) {
      case LoginInitial() when initial != null:
        return initial(_that);
      case LoginRestoring() when restoring != null:
        return restoring(_that);
      case LoginLoading() when loading != null:
        return loading(_that);
      case LoginPendingSignup() when pendingSignup != null:
        return pendingSignup(_that);
      case LoginAuthenticated() when authenticated != null:
        return authenticated(_that);
      case LoginSignupComplete() when signupComplete != null:
        return signupComplete(_that);
      case LoginSessionExpired() when sessionExpired != null:
        return sessionExpired(_that);
      case LoginUnauthenticated() when unauthenticated != null:
        return unauthenticated(_that);
      case LoginFailure() when failure != null:
        return failure(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? restoring,
    TResult Function()? loading,
    TResult Function(User user, String email)? pendingSignup,
    TResult Function(User user)? authenticated,
    TResult Function()? signupComplete,
    TResult Function()? sessionExpired,
    TResult Function()? unauthenticated,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LoginInitial() when initial != null:
        return initial();
      case LoginRestoring() when restoring != null:
        return restoring();
      case LoginLoading() when loading != null:
        return loading();
      case LoginPendingSignup() when pendingSignup != null:
        return pendingSignup(_that.user, _that.email);
      case LoginAuthenticated() when authenticated != null:
        return authenticated(_that.user);
      case LoginSignupComplete() when signupComplete != null:
        return signupComplete();
      case LoginSessionExpired() when sessionExpired != null:
        return sessionExpired();
      case LoginUnauthenticated() when unauthenticated != null:
        return unauthenticated();
      case LoginFailure() when failure != null:
        return failure(_that.message);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() restoring,
    required TResult Function() loading,
    required TResult Function(User user, String email) pendingSignup,
    required TResult Function(User user) authenticated,
    required TResult Function() signupComplete,
    required TResult Function() sessionExpired,
    required TResult Function() unauthenticated,
    required TResult Function(String message) failure,
  }) {
    final _that = this;
    switch (_that) {
      case LoginInitial():
        return initial();
      case LoginRestoring():
        return restoring();
      case LoginLoading():
        return loading();
      case LoginPendingSignup():
        return pendingSignup(_that.user, _that.email);
      case LoginAuthenticated():
        return authenticated(_that.user);
      case LoginSignupComplete():
        return signupComplete();
      case LoginSessionExpired():
        return sessionExpired();
      case LoginUnauthenticated():
        return unauthenticated();
      case LoginFailure():
        return failure(_that.message);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? restoring,
    TResult? Function()? loading,
    TResult? Function(User user, String email)? pendingSignup,
    TResult? Function(User user)? authenticated,
    TResult? Function()? signupComplete,
    TResult? Function()? sessionExpired,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? failure,
  }) {
    final _that = this;
    switch (_that) {
      case LoginInitial() when initial != null:
        return initial();
      case LoginRestoring() when restoring != null:
        return restoring();
      case LoginLoading() when loading != null:
        return loading();
      case LoginPendingSignup() when pendingSignup != null:
        return pendingSignup(_that.user, _that.email);
      case LoginAuthenticated() when authenticated != null:
        return authenticated(_that.user);
      case LoginSignupComplete() when signupComplete != null:
        return signupComplete();
      case LoginSessionExpired() when sessionExpired != null:
        return sessionExpired();
      case LoginUnauthenticated() when unauthenticated != null:
        return unauthenticated();
      case LoginFailure() when failure != null:
        return failure(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class LoginInitial implements LoginState {
  const LoginInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginState.initial()';
  }
}

/// @nodoc

class LoginRestoring implements LoginState {
  const LoginRestoring();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginRestoring);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginState.restoring()';
  }
}

/// @nodoc

class LoginLoading implements LoginState {
  const LoginLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginState.loading()';
  }
}

/// @nodoc

class LoginPendingSignup implements LoginState {
  const LoginPendingSignup({required this.user, required this.email});

  final User user;
  final String email;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginPendingSignupCopyWith<LoginPendingSignup> get copyWith =>
      _$LoginPendingSignupCopyWithImpl<LoginPendingSignup>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginPendingSignup &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, email);

  @override
  String toString() {
    return 'LoginState.pendingSignup(user: $user, email: $email)';
  }
}

/// @nodoc
abstract mixin class $LoginPendingSignupCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory $LoginPendingSignupCopyWith(
          LoginPendingSignup value, $Res Function(LoginPendingSignup) _then) =
      _$LoginPendingSignupCopyWithImpl;
  @useResult
  $Res call({User user, String email});
}

/// @nodoc
class _$LoginPendingSignupCopyWithImpl<$Res>
    implements $LoginPendingSignupCopyWith<$Res> {
  _$LoginPendingSignupCopyWithImpl(this._self, this._then);

  final LoginPendingSignup _self;
  final $Res Function(LoginPendingSignup) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = null,
    Object? email = null,
  }) {
    return _then(LoginPendingSignup(
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class LoginAuthenticated implements LoginState {
  const LoginAuthenticated(this.user);

  final User user;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginAuthenticatedCopyWith<LoginAuthenticated> get copyWith =>
      _$LoginAuthenticatedCopyWithImpl<LoginAuthenticated>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginAuthenticated &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @override
  String toString() {
    return 'LoginState.authenticated(user: $user)';
  }
}

/// @nodoc
abstract mixin class $LoginAuthenticatedCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory $LoginAuthenticatedCopyWith(
          LoginAuthenticated value, $Res Function(LoginAuthenticated) _then) =
      _$LoginAuthenticatedCopyWithImpl;
  @useResult
  $Res call({User user});
}

/// @nodoc
class _$LoginAuthenticatedCopyWithImpl<$Res>
    implements $LoginAuthenticatedCopyWith<$Res> {
  _$LoginAuthenticatedCopyWithImpl(this._self, this._then);

  final LoginAuthenticated _self;
  final $Res Function(LoginAuthenticated) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = null,
  }) {
    return _then(LoginAuthenticated(
      null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class LoginSignupComplete implements LoginState {
  const LoginSignupComplete();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginSignupComplete);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginState.signupComplete()';
  }
}

/// @nodoc

class LoginSessionExpired implements LoginState {
  const LoginSessionExpired();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginSessionExpired);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginState.sessionExpired()';
  }
}

/// @nodoc

class LoginUnauthenticated implements LoginState {
  const LoginUnauthenticated();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginUnauthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginState.unauthenticated()';
  }
}

/// @nodoc

class LoginFailure implements LoginState {
  const LoginFailure(this.message);

  final String message;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginFailureCopyWith<LoginFailure> get copyWith =>
      _$LoginFailureCopyWithImpl<LoginFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'LoginState.failure(message: $message)';
  }
}

/// @nodoc
abstract mixin class $LoginFailureCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory $LoginFailureCopyWith(
          LoginFailure value, $Res Function(LoginFailure) _then) =
      _$LoginFailureCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$LoginFailureCopyWithImpl<$Res> implements $LoginFailureCopyWith<$Res> {
  _$LoginFailureCopyWithImpl(this._self, this._then);

  final LoginFailure _self;
  final $Res Function(LoginFailure) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(LoginFailure(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
