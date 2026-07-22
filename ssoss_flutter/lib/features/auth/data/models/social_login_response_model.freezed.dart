// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_login_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialLoginResponseModel {
  @JsonKey(fromJson: _memberStatusFromJson, toJson: _memberStatusToJson)
  MemberStatus get status;
  String get accessToken;
  String get refreshToken;

  /// Create a copy of SocialLoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SocialLoginResponseModelCopyWith<SocialLoginResponseModel> get copyWith =>
      _$SocialLoginResponseModelCopyWithImpl<SocialLoginResponseModel>(
          this as SocialLoginResponseModel, _$identity);

  /// Serializes this SocialLoginResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SocialLoginResponseModel &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, accessToken, refreshToken);

  @override
  String toString() {
    return 'SocialLoginResponseModel(status: $status, accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class $SocialLoginResponseModelCopyWith<$Res> {
  factory $SocialLoginResponseModelCopyWith(SocialLoginResponseModel value,
          $Res Function(SocialLoginResponseModel) _then) =
      _$SocialLoginResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _memberStatusFromJson, toJson: _memberStatusToJson)
      MemberStatus status,
      String accessToken,
      String refreshToken});
}

/// @nodoc
class _$SocialLoginResponseModelCopyWithImpl<$Res>
    implements $SocialLoginResponseModelCopyWith<$Res> {
  _$SocialLoginResponseModelCopyWithImpl(this._self, this._then);

  final SocialLoginResponseModel _self;
  final $Res Function(SocialLoginResponseModel) _then;

  /// Create a copy of SocialLoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as MemberStatus,
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SocialLoginResponseModel].
extension SocialLoginResponseModelPatterns on SocialLoginResponseModel {
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
    TResult Function(_SocialLoginResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SocialLoginResponseModel() when $default != null:
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
    TResult Function(_SocialLoginResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SocialLoginResponseModel():
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
    TResult? Function(_SocialLoginResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SocialLoginResponseModel() when $default != null:
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
    TResult Function(
            @JsonKey(
                fromJson: _memberStatusFromJson, toJson: _memberStatusToJson)
            MemberStatus status,
            String accessToken,
            String refreshToken)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SocialLoginResponseModel() when $default != null:
        return $default(_that.status, _that.accessToken, _that.refreshToken);
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
    TResult Function(
            @JsonKey(
                fromJson: _memberStatusFromJson, toJson: _memberStatusToJson)
            MemberStatus status,
            String accessToken,
            String refreshToken)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SocialLoginResponseModel():
        return $default(_that.status, _that.accessToken, _that.refreshToken);
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
    TResult? Function(
            @JsonKey(
                fromJson: _memberStatusFromJson, toJson: _memberStatusToJson)
            MemberStatus status,
            String accessToken,
            String refreshToken)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SocialLoginResponseModel() when $default != null:
        return $default(_that.status, _that.accessToken, _that.refreshToken);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SocialLoginResponseModel implements SocialLoginResponseModel {
  const _SocialLoginResponseModel(
      {@JsonKey(fromJson: _memberStatusFromJson, toJson: _memberStatusToJson)
      required this.status,
      required this.accessToken,
      required this.refreshToken});
  factory _SocialLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginResponseModelFromJson(json);

  @override
  @JsonKey(fromJson: _memberStatusFromJson, toJson: _memberStatusToJson)
  final MemberStatus status;
  @override
  final String accessToken;
  @override
  final String refreshToken;

  /// Create a copy of SocialLoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SocialLoginResponseModelCopyWith<_SocialLoginResponseModel> get copyWith =>
      __$SocialLoginResponseModelCopyWithImpl<_SocialLoginResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SocialLoginResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SocialLoginResponseModel &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, accessToken, refreshToken);

  @override
  String toString() {
    return 'SocialLoginResponseModel(status: $status, accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class _$SocialLoginResponseModelCopyWith<$Res>
    implements $SocialLoginResponseModelCopyWith<$Res> {
  factory _$SocialLoginResponseModelCopyWith(_SocialLoginResponseModel value,
          $Res Function(_SocialLoginResponseModel) _then) =
      __$SocialLoginResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _memberStatusFromJson, toJson: _memberStatusToJson)
      MemberStatus status,
      String accessToken,
      String refreshToken});
}

/// @nodoc
class __$SocialLoginResponseModelCopyWithImpl<$Res>
    implements _$SocialLoginResponseModelCopyWith<$Res> {
  __$SocialLoginResponseModelCopyWithImpl(this._self, this._then);

  final _SocialLoginResponseModel _self;
  final $Res Function(_SocialLoginResponseModel) _then;

  /// Create a copy of SocialLoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_SocialLoginResponseModel(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as MemberStatus,
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
