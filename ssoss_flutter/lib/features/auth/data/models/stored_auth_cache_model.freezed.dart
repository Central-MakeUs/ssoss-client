// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stored_auth_cache_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoredAuthCacheModel {
  AuthTokenModel get token;
  String get provider;
  String get userId;
  String get nickname;
  String? get email;

  /// Create a copy of StoredAuthCacheModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StoredAuthCacheModelCopyWith<StoredAuthCacheModel> get copyWith =>
      _$StoredAuthCacheModelCopyWithImpl<StoredAuthCacheModel>(
          this as StoredAuthCacheModel, _$identity);

  /// Serializes this StoredAuthCacheModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StoredAuthCacheModel &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, token, provider, userId, nickname, email);

  @override
  String toString() {
    return 'StoredAuthCacheModel(token: $token, provider: $provider, userId: $userId, nickname: $nickname, email: $email)';
  }
}

/// @nodoc
abstract mixin class $StoredAuthCacheModelCopyWith<$Res> {
  factory $StoredAuthCacheModelCopyWith(StoredAuthCacheModel value,
          $Res Function(StoredAuthCacheModel) _then) =
      _$StoredAuthCacheModelCopyWithImpl;
  @useResult
  $Res call(
      {AuthTokenModel token,
      String provider,
      String userId,
      String nickname,
      String? email});

  $AuthTokenModelCopyWith<$Res> get token;
}

/// @nodoc
class _$StoredAuthCacheModelCopyWithImpl<$Res>
    implements $StoredAuthCacheModelCopyWith<$Res> {
  _$StoredAuthCacheModelCopyWithImpl(this._self, this._then);

  final StoredAuthCacheModel _self;
  final $Res Function(StoredAuthCacheModel) _then;

  /// Create a copy of StoredAuthCacheModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? provider = null,
    Object? userId = null,
    Object? nickname = null,
    Object? email = freezed,
  }) {
    return _then(_self.copyWith(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as AuthTokenModel,
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of StoredAuthCacheModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthTokenModelCopyWith<$Res> get token {
    return $AuthTokenModelCopyWith<$Res>(_self.token, (value) {
      return _then(_self.copyWith(token: value));
    });
  }
}

/// Adds pattern-matching-related methods to [StoredAuthCacheModel].
extension StoredAuthCacheModelPatterns on StoredAuthCacheModel {
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
    TResult Function(_StoredAuthCacheModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StoredAuthCacheModel() when $default != null:
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
    TResult Function(_StoredAuthCacheModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoredAuthCacheModel():
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
    TResult? Function(_StoredAuthCacheModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoredAuthCacheModel() when $default != null:
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
    TResult Function(AuthTokenModel token, String provider, String userId,
            String nickname, String? email)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StoredAuthCacheModel() when $default != null:
        return $default(_that.token, _that.provider, _that.userId,
            _that.nickname, _that.email);
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
    TResult Function(AuthTokenModel token, String provider, String userId,
            String nickname, String? email)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoredAuthCacheModel():
        return $default(_that.token, _that.provider, _that.userId,
            _that.nickname, _that.email);
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
    TResult? Function(AuthTokenModel token, String provider, String userId,
            String nickname, String? email)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoredAuthCacheModel() when $default != null:
        return $default(_that.token, _that.provider, _that.userId,
            _that.nickname, _that.email);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _StoredAuthCacheModel implements StoredAuthCacheModel {
  const _StoredAuthCacheModel(
      {required this.token,
      required this.provider,
      required this.userId,
      required this.nickname,
      this.email});
  factory _StoredAuthCacheModel.fromJson(Map<String, dynamic> json) =>
      _$StoredAuthCacheModelFromJson(json);

  @override
  final AuthTokenModel token;
  @override
  final String provider;
  @override
  final String userId;
  @override
  final String nickname;
  @override
  final String? email;

  /// Create a copy of StoredAuthCacheModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StoredAuthCacheModelCopyWith<_StoredAuthCacheModel> get copyWith =>
      __$StoredAuthCacheModelCopyWithImpl<_StoredAuthCacheModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StoredAuthCacheModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StoredAuthCacheModel &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, token, provider, userId, nickname, email);

  @override
  String toString() {
    return 'StoredAuthCacheModel(token: $token, provider: $provider, userId: $userId, nickname: $nickname, email: $email)';
  }
}

/// @nodoc
abstract mixin class _$StoredAuthCacheModelCopyWith<$Res>
    implements $StoredAuthCacheModelCopyWith<$Res> {
  factory _$StoredAuthCacheModelCopyWith(_StoredAuthCacheModel value,
          $Res Function(_StoredAuthCacheModel) _then) =
      __$StoredAuthCacheModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {AuthTokenModel token,
      String provider,
      String userId,
      String nickname,
      String? email});

  @override
  $AuthTokenModelCopyWith<$Res> get token;
}

/// @nodoc
class __$StoredAuthCacheModelCopyWithImpl<$Res>
    implements _$StoredAuthCacheModelCopyWith<$Res> {
  __$StoredAuthCacheModelCopyWithImpl(this._self, this._then);

  final _StoredAuthCacheModel _self;
  final $Res Function(_StoredAuthCacheModel) _then;

  /// Create a copy of StoredAuthCacheModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? token = null,
    Object? provider = null,
    Object? userId = null,
    Object? nickname = null,
    Object? email = freezed,
  }) {
    return _then(_StoredAuthCacheModel(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as AuthTokenModel,
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of StoredAuthCacheModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthTokenModelCopyWith<$Res> get token {
    return $AuthTokenModelCopyWith<$Res>(_self.token, (value) {
      return _then(_self.copyWith(token: value));
    });
  }
}

// dart format on
