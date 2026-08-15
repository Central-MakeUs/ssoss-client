// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_version_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppVersionResponseModel {
  String get minimumVersion;
  bool get updateRequired;

  /// Create a copy of AppVersionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppVersionResponseModelCopyWith<AppVersionResponseModel> get copyWith =>
      _$AppVersionResponseModelCopyWithImpl<AppVersionResponseModel>(
          this as AppVersionResponseModel, _$identity);

  /// Serializes this AppVersionResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppVersionResponseModel &&
            (identical(other.minimumVersion, minimumVersion) ||
                other.minimumVersion == minimumVersion) &&
            (identical(other.updateRequired, updateRequired) ||
                other.updateRequired == updateRequired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, minimumVersion, updateRequired);

  @override
  String toString() {
    return 'AppVersionResponseModel(minimumVersion: $minimumVersion, updateRequired: $updateRequired)';
  }
}

/// @nodoc
abstract mixin class $AppVersionResponseModelCopyWith<$Res> {
  factory $AppVersionResponseModelCopyWith(AppVersionResponseModel value,
          $Res Function(AppVersionResponseModel) _then) =
      _$AppVersionResponseModelCopyWithImpl;
  @useResult
  $Res call({String minimumVersion, bool updateRequired});
}

/// @nodoc
class _$AppVersionResponseModelCopyWithImpl<$Res>
    implements $AppVersionResponseModelCopyWith<$Res> {
  _$AppVersionResponseModelCopyWithImpl(this._self, this._then);

  final AppVersionResponseModel _self;
  final $Res Function(AppVersionResponseModel) _then;

  /// Create a copy of AppVersionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minimumVersion = null,
    Object? updateRequired = null,
  }) {
    return _then(_self.copyWith(
      minimumVersion: null == minimumVersion
          ? _self.minimumVersion
          : minimumVersion // ignore: cast_nullable_to_non_nullable
              as String,
      updateRequired: null == updateRequired
          ? _self.updateRequired
          : updateRequired // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppVersionResponseModel].
extension AppVersionResponseModelPatterns on AppVersionResponseModel {
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
    TResult Function(_AppVersionResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppVersionResponseModel() when $default != null:
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
    TResult Function(_AppVersionResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppVersionResponseModel():
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
    TResult? Function(_AppVersionResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppVersionResponseModel() when $default != null:
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
    TResult Function(String minimumVersion, bool updateRequired)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppVersionResponseModel() when $default != null:
        return $default(_that.minimumVersion, _that.updateRequired);
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
    TResult Function(String minimumVersion, bool updateRequired) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppVersionResponseModel():
        return $default(_that.minimumVersion, _that.updateRequired);
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
    TResult? Function(String minimumVersion, bool updateRequired)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppVersionResponseModel() when $default != null:
        return $default(_that.minimumVersion, _that.updateRequired);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AppVersionResponseModel implements AppVersionResponseModel {
  const _AppVersionResponseModel(
      {required this.minimumVersion, required this.updateRequired});
  factory _AppVersionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionResponseModelFromJson(json);

  @override
  final String minimumVersion;
  @override
  final bool updateRequired;

  /// Create a copy of AppVersionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppVersionResponseModelCopyWith<_AppVersionResponseModel> get copyWith =>
      __$AppVersionResponseModelCopyWithImpl<_AppVersionResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppVersionResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppVersionResponseModel &&
            (identical(other.minimumVersion, minimumVersion) ||
                other.minimumVersion == minimumVersion) &&
            (identical(other.updateRequired, updateRequired) ||
                other.updateRequired == updateRequired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, minimumVersion, updateRequired);

  @override
  String toString() {
    return 'AppVersionResponseModel(minimumVersion: $minimumVersion, updateRequired: $updateRequired)';
  }
}

/// @nodoc
abstract mixin class _$AppVersionResponseModelCopyWith<$Res>
    implements $AppVersionResponseModelCopyWith<$Res> {
  factory _$AppVersionResponseModelCopyWith(_AppVersionResponseModel value,
          $Res Function(_AppVersionResponseModel) _then) =
      __$AppVersionResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call({String minimumVersion, bool updateRequired});
}

/// @nodoc
class __$AppVersionResponseModelCopyWithImpl<$Res>
    implements _$AppVersionResponseModelCopyWith<$Res> {
  __$AppVersionResponseModelCopyWithImpl(this._self, this._then);

  final _AppVersionResponseModel _self;
  final $Res Function(_AppVersionResponseModel) _then;

  /// Create a copy of AppVersionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? minimumVersion = null,
    Object? updateRequired = null,
  }) {
    return _then(_AppVersionResponseModel(
      minimumVersion: null == minimumVersion
          ? _self.minimumVersion
          : minimumVersion // ignore: cast_nullable_to_non_nullable
              as String,
      updateRequired: null == updateRequired
          ? _self.updateRequired
          : updateRequired // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
