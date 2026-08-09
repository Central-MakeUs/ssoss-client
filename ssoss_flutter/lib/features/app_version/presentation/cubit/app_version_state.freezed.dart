// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_version_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppVersionState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AppVersionState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppVersionState()';
  }
}

/// @nodoc
class $AppVersionStateCopyWith<$Res> {
  $AppVersionStateCopyWith(
      AppVersionState _, $Res Function(AppVersionState) __);
}

/// Adds pattern-matching-related methods to [AppVersionState].
extension AppVersionStatePatterns on AppVersionState {
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
    TResult Function(AppVersionChecking value)? checking,
    TResult Function(AppVersionUpdateRequired value)? updateRequired,
    TResult Function(AppVersionNetworkUnavailable value)? networkUnavailable,
    TResult Function(AppVersionAllowed value)? allowed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AppVersionChecking() when checking != null:
        return checking(_that);
      case AppVersionUpdateRequired() when updateRequired != null:
        return updateRequired(_that);
      case AppVersionNetworkUnavailable() when networkUnavailable != null:
        return networkUnavailable(_that);
      case AppVersionAllowed() when allowed != null:
        return allowed(_that);
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
    required TResult Function(AppVersionChecking value) checking,
    required TResult Function(AppVersionUpdateRequired value) updateRequired,
    required TResult Function(AppVersionNetworkUnavailable value)
        networkUnavailable,
    required TResult Function(AppVersionAllowed value) allowed,
  }) {
    final _that = this;
    switch (_that) {
      case AppVersionChecking():
        return checking(_that);
      case AppVersionUpdateRequired():
        return updateRequired(_that);
      case AppVersionNetworkUnavailable():
        return networkUnavailable(_that);
      case AppVersionAllowed():
        return allowed(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(AppVersionChecking value)? checking,
    TResult? Function(AppVersionUpdateRequired value)? updateRequired,
    TResult? Function(AppVersionNetworkUnavailable value)? networkUnavailable,
    TResult? Function(AppVersionAllowed value)? allowed,
  }) {
    final _that = this;
    switch (_that) {
      case AppVersionChecking() when checking != null:
        return checking(_that);
      case AppVersionUpdateRequired() when updateRequired != null:
        return updateRequired(_that);
      case AppVersionNetworkUnavailable() when networkUnavailable != null:
        return networkUnavailable(_that);
      case AppVersionAllowed() when allowed != null:
        return allowed(_that);
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
    TResult Function()? checking,
    TResult Function(String minimumVersion)? updateRequired,
    TResult Function()? networkUnavailable,
    TResult Function()? allowed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AppVersionChecking() when checking != null:
        return checking();
      case AppVersionUpdateRequired() when updateRequired != null:
        return updateRequired(_that.minimumVersion);
      case AppVersionNetworkUnavailable() when networkUnavailable != null:
        return networkUnavailable();
      case AppVersionAllowed() when allowed != null:
        return allowed();
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
    required TResult Function() checking,
    required TResult Function(String minimumVersion) updateRequired,
    required TResult Function() networkUnavailable,
    required TResult Function() allowed,
  }) {
    final _that = this;
    switch (_that) {
      case AppVersionChecking():
        return checking();
      case AppVersionUpdateRequired():
        return updateRequired(_that.minimumVersion);
      case AppVersionNetworkUnavailable():
        return networkUnavailable();
      case AppVersionAllowed():
        return allowed();
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function()? checking,
    TResult? Function(String minimumVersion)? updateRequired,
    TResult? Function()? networkUnavailable,
    TResult? Function()? allowed,
  }) {
    final _that = this;
    switch (_that) {
      case AppVersionChecking() when checking != null:
        return checking();
      case AppVersionUpdateRequired() when updateRequired != null:
        return updateRequired(_that.minimumVersion);
      case AppVersionNetworkUnavailable() when networkUnavailable != null:
        return networkUnavailable();
      case AppVersionAllowed() when allowed != null:
        return allowed();
      case _:
        return null;
    }
  }
}

/// @nodoc

class AppVersionChecking implements AppVersionState {
  const AppVersionChecking();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AppVersionChecking);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppVersionState.checking()';
  }
}

/// @nodoc

class AppVersionUpdateRequired implements AppVersionState {
  const AppVersionUpdateRequired({required this.minimumVersion});

  final String minimumVersion;

  /// Create a copy of AppVersionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppVersionUpdateRequiredCopyWith<AppVersionUpdateRequired> get copyWith =>
      _$AppVersionUpdateRequiredCopyWithImpl<AppVersionUpdateRequired>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppVersionUpdateRequired &&
            (identical(other.minimumVersion, minimumVersion) ||
                other.minimumVersion == minimumVersion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, minimumVersion);

  @override
  String toString() {
    return 'AppVersionState.updateRequired(minimumVersion: $minimumVersion)';
  }
}

/// @nodoc
abstract mixin class $AppVersionUpdateRequiredCopyWith<$Res>
    implements $AppVersionStateCopyWith<$Res> {
  factory $AppVersionUpdateRequiredCopyWith(AppVersionUpdateRequired value,
          $Res Function(AppVersionUpdateRequired) _then) =
      _$AppVersionUpdateRequiredCopyWithImpl;
  @useResult
  $Res call({String minimumVersion});
}

/// @nodoc
class _$AppVersionUpdateRequiredCopyWithImpl<$Res>
    implements $AppVersionUpdateRequiredCopyWith<$Res> {
  _$AppVersionUpdateRequiredCopyWithImpl(this._self, this._then);

  final AppVersionUpdateRequired _self;
  final $Res Function(AppVersionUpdateRequired) _then;

  /// Create a copy of AppVersionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? minimumVersion = null,
  }) {
    return _then(AppVersionUpdateRequired(
      minimumVersion: null == minimumVersion
          ? _self.minimumVersion
          : minimumVersion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AppVersionNetworkUnavailable implements AppVersionState {
  const AppVersionNetworkUnavailable();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppVersionNetworkUnavailable);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppVersionState.networkUnavailable()';
  }
}

/// @nodoc

class AppVersionAllowed implements AppVersionState {
  const AppVersionAllowed();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AppVersionAllowed);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppVersionState.allowed()';
  }
}

// dart format on
