// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginEvent()';
  }
}

/// @nodoc
class $LoginEventCopyWith<$Res> {
  $LoginEventCopyWith(LoginEvent _, $Res Function(LoginEvent) __);
}

/// Adds pattern-matching-related methods to [LoginEvent].
extension LoginEventPatterns on LoginEvent {
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
    TResult Function(NaverLoginRequested value)? naverLoginRequested,
    TResult Function(AppleLoginRequested value)? appleLoginRequested,
    TResult Function(WithdrawRequested value)? withdrawRequested,
    TResult Function(SessionRestoreRequested value)? sessionRestoreRequested,
    TResult Function(LogoutRequested value)? logoutRequested,
    TResult Function(SessionExpired value)? sessionExpired,
    TResult Function(SessionExpiredAcknowledged value)?
        sessionExpiredAcknowledged,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NaverLoginRequested() when naverLoginRequested != null:
        return naverLoginRequested(_that);
      case AppleLoginRequested() when appleLoginRequested != null:
        return appleLoginRequested(_that);
      case WithdrawRequested() when withdrawRequested != null:
        return withdrawRequested(_that);
      case SessionRestoreRequested() when sessionRestoreRequested != null:
        return sessionRestoreRequested(_that);
      case LogoutRequested() when logoutRequested != null:
        return logoutRequested(_that);
      case SessionExpired() when sessionExpired != null:
        return sessionExpired(_that);
      case SessionExpiredAcknowledged() when sessionExpiredAcknowledged != null:
        return sessionExpiredAcknowledged(_that);
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
    required TResult Function(NaverLoginRequested value) naverLoginRequested,
    required TResult Function(AppleLoginRequested value) appleLoginRequested,
    required TResult Function(WithdrawRequested value) withdrawRequested,
    required TResult Function(SessionRestoreRequested value)
        sessionRestoreRequested,
    required TResult Function(LogoutRequested value) logoutRequested,
    required TResult Function(SessionExpired value) sessionExpired,
    required TResult Function(SessionExpiredAcknowledged value)
        sessionExpiredAcknowledged,
  }) {
    final _that = this;
    switch (_that) {
      case NaverLoginRequested():
        return naverLoginRequested(_that);
      case AppleLoginRequested():
        return appleLoginRequested(_that);
      case WithdrawRequested():
        return withdrawRequested(_that);
      case SessionRestoreRequested():
        return sessionRestoreRequested(_that);
      case LogoutRequested():
        return logoutRequested(_that);
      case SessionExpired():
        return sessionExpired(_that);
      case SessionExpiredAcknowledged():
        return sessionExpiredAcknowledged(_that);
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
    TResult? Function(NaverLoginRequested value)? naverLoginRequested,
    TResult? Function(AppleLoginRequested value)? appleLoginRequested,
    TResult? Function(WithdrawRequested value)? withdrawRequested,
    TResult? Function(SessionRestoreRequested value)? sessionRestoreRequested,
    TResult? Function(LogoutRequested value)? logoutRequested,
    TResult? Function(SessionExpired value)? sessionExpired,
    TResult? Function(SessionExpiredAcknowledged value)?
        sessionExpiredAcknowledged,
  }) {
    final _that = this;
    switch (_that) {
      case NaverLoginRequested() when naverLoginRequested != null:
        return naverLoginRequested(_that);
      case AppleLoginRequested() when appleLoginRequested != null:
        return appleLoginRequested(_that);
      case WithdrawRequested() when withdrawRequested != null:
        return withdrawRequested(_that);
      case SessionRestoreRequested() when sessionRestoreRequested != null:
        return sessionRestoreRequested(_that);
      case LogoutRequested() when logoutRequested != null:
        return logoutRequested(_that);
      case SessionExpired() when sessionExpired != null:
        return sessionExpired(_that);
      case SessionExpiredAcknowledged() when sessionExpiredAcknowledged != null:
        return sessionExpiredAcknowledged(_that);
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
    TResult Function()? naverLoginRequested,
    TResult Function()? appleLoginRequested,
    TResult Function()? withdrawRequested,
    TResult Function()? sessionRestoreRequested,
    TResult Function()? logoutRequested,
    TResult Function()? sessionExpired,
    TResult Function()? sessionExpiredAcknowledged,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NaverLoginRequested() when naverLoginRequested != null:
        return naverLoginRequested();
      case AppleLoginRequested() when appleLoginRequested != null:
        return appleLoginRequested();
      case WithdrawRequested() when withdrawRequested != null:
        return withdrawRequested();
      case SessionRestoreRequested() when sessionRestoreRequested != null:
        return sessionRestoreRequested();
      case LogoutRequested() when logoutRequested != null:
        return logoutRequested();
      case SessionExpired() when sessionExpired != null:
        return sessionExpired();
      case SessionExpiredAcknowledged() when sessionExpiredAcknowledged != null:
        return sessionExpiredAcknowledged();
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
    required TResult Function() naverLoginRequested,
    required TResult Function() appleLoginRequested,
    required TResult Function() withdrawRequested,
    required TResult Function() sessionRestoreRequested,
    required TResult Function() logoutRequested,
    required TResult Function() sessionExpired,
    required TResult Function() sessionExpiredAcknowledged,
  }) {
    final _that = this;
    switch (_that) {
      case NaverLoginRequested():
        return naverLoginRequested();
      case AppleLoginRequested():
        return appleLoginRequested();
      case WithdrawRequested():
        return withdrawRequested();
      case SessionRestoreRequested():
        return sessionRestoreRequested();
      case LogoutRequested():
        return logoutRequested();
      case SessionExpired():
        return sessionExpired();
      case SessionExpiredAcknowledged():
        return sessionExpiredAcknowledged();
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
    TResult? Function()? naverLoginRequested,
    TResult? Function()? appleLoginRequested,
    TResult? Function()? withdrawRequested,
    TResult? Function()? sessionRestoreRequested,
    TResult? Function()? logoutRequested,
    TResult? Function()? sessionExpired,
    TResult? Function()? sessionExpiredAcknowledged,
  }) {
    final _that = this;
    switch (_that) {
      case NaverLoginRequested() when naverLoginRequested != null:
        return naverLoginRequested();
      case AppleLoginRequested() when appleLoginRequested != null:
        return appleLoginRequested();
      case WithdrawRequested() when withdrawRequested != null:
        return withdrawRequested();
      case SessionRestoreRequested() when sessionRestoreRequested != null:
        return sessionRestoreRequested();
      case LogoutRequested() when logoutRequested != null:
        return logoutRequested();
      case SessionExpired() when sessionExpired != null:
        return sessionExpired();
      case SessionExpiredAcknowledged() when sessionExpiredAcknowledged != null:
        return sessionExpiredAcknowledged();
      case _:
        return null;
    }
  }
}

/// @nodoc

class NaverLoginRequested implements LoginEvent {
  const NaverLoginRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NaverLoginRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginEvent.naverLoginRequested()';
  }
}

/// @nodoc

class AppleLoginRequested implements LoginEvent {
  const AppleLoginRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AppleLoginRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginEvent.appleLoginRequested()';
  }
}

/// @nodoc

class WithdrawRequested implements LoginEvent {
  const WithdrawRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WithdrawRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginEvent.withdrawRequested()';
  }
}

/// @nodoc

class SessionRestoreRequested implements LoginEvent {
  const SessionRestoreRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SessionRestoreRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginEvent.sessionRestoreRequested()';
  }
}

/// @nodoc

class LogoutRequested implements LoginEvent {
  const LogoutRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LogoutRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginEvent.logoutRequested()';
  }
}

/// @nodoc

class SessionExpired implements LoginEvent {
  const SessionExpired();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SessionExpired);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginEvent.sessionExpired()';
  }
}

/// @nodoc

class SessionExpiredAcknowledged implements LoginEvent {
  const SessionExpiredAcknowledged();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SessionExpiredAcknowledged);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginEvent.sessionExpiredAcknowledged()';
  }
}

// dart format on
