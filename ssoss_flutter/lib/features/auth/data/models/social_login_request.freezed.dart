// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_login_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialLoginRequest {
  String get accessToken;

  /// Create a copy of SocialLoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SocialLoginRequestCopyWith<SocialLoginRequest> get copyWith =>
      _$SocialLoginRequestCopyWithImpl<SocialLoginRequest>(
          this as SocialLoginRequest, _$identity);

  /// Serializes this SocialLoginRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SocialLoginRequest &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken);

  @override
  String toString() {
    return 'SocialLoginRequest(accessToken: $accessToken)';
  }
}

/// @nodoc
abstract mixin class $SocialLoginRequestCopyWith<$Res> {
  factory $SocialLoginRequestCopyWith(
          SocialLoginRequest value, $Res Function(SocialLoginRequest) _then) =
      _$SocialLoginRequestCopyWithImpl;
  @useResult
  $Res call({String accessToken});
}

/// @nodoc
class _$SocialLoginRequestCopyWithImpl<$Res>
    implements $SocialLoginRequestCopyWith<$Res> {
  _$SocialLoginRequestCopyWithImpl(this._self, this._then);

  final SocialLoginRequest _self;
  final $Res Function(SocialLoginRequest) _then;

  /// Create a copy of SocialLoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
  }) {
    return _then(_self.copyWith(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SocialLoginRequest].
extension SocialLoginRequestPatterns on SocialLoginRequest {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SocialLoginRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SocialLoginRequest() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_SocialLoginRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SocialLoginRequest():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SocialLoginRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SocialLoginRequest() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String accessToken)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SocialLoginRequest() when $default != null:
        return $default(_that.accessToken);
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
  TResult when<TResult extends Object?>(
    TResult Function(String accessToken) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SocialLoginRequest():
        return $default(_that.accessToken);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String accessToken)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SocialLoginRequest() when $default != null:
        return $default(_that.accessToken);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SocialLoginRequest implements SocialLoginRequest {
  const _SocialLoginRequest({required this.accessToken});
  factory _SocialLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginRequestFromJson(json);

  @override
  final String accessToken;

  /// Create a copy of SocialLoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SocialLoginRequestCopyWith<_SocialLoginRequest> get copyWith =>
      __$SocialLoginRequestCopyWithImpl<_SocialLoginRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SocialLoginRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SocialLoginRequest &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken);

  @override
  String toString() {
    return 'SocialLoginRequest(accessToken: $accessToken)';
  }
}

/// @nodoc
abstract mixin class _$SocialLoginRequestCopyWith<$Res>
    implements $SocialLoginRequestCopyWith<$Res> {
  factory _$SocialLoginRequestCopyWith(
          _SocialLoginRequest value, $Res Function(_SocialLoginRequest) _then) =
      __$SocialLoginRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String accessToken});
}

/// @nodoc
class __$SocialLoginRequestCopyWithImpl<$Res>
    implements _$SocialLoginRequestCopyWith<$Res> {
  __$SocialLoginRequestCopyWithImpl(this._self, this._then);

  final _SocialLoginRequest _self;
  final $Res Function(_SocialLoginRequest) _then;

  /// Create a copy of SocialLoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? accessToken = null,
  }) {
    return _then(_SocialLoginRequest(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
