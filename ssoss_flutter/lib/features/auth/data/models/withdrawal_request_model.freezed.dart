// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'withdrawal_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WithdrawalRequestModel {
  String get reasonCode;
  String? get reasonDetail;

  /// Create a copy of WithdrawalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WithdrawalRequestModelCopyWith<WithdrawalRequestModel> get copyWith =>
      _$WithdrawalRequestModelCopyWithImpl<WithdrawalRequestModel>(
          this as WithdrawalRequestModel, _$identity);

  /// Serializes this WithdrawalRequestModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WithdrawalRequestModel &&
            (identical(other.reasonCode, reasonCode) ||
                other.reasonCode == reasonCode) &&
            (identical(other.reasonDetail, reasonDetail) ||
                other.reasonDetail == reasonDetail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reasonCode, reasonDetail);

  @override
  String toString() {
    return 'WithdrawalRequestModel(reasonCode: $reasonCode, reasonDetail: $reasonDetail)';
  }
}

/// @nodoc
abstract mixin class $WithdrawalRequestModelCopyWith<$Res> {
  factory $WithdrawalRequestModelCopyWith(WithdrawalRequestModel value,
          $Res Function(WithdrawalRequestModel) _then) =
      _$WithdrawalRequestModelCopyWithImpl;
  @useResult
  $Res call({String reasonCode, String? reasonDetail});
}

/// @nodoc
class _$WithdrawalRequestModelCopyWithImpl<$Res>
    implements $WithdrawalRequestModelCopyWith<$Res> {
  _$WithdrawalRequestModelCopyWithImpl(this._self, this._then);

  final WithdrawalRequestModel _self;
  final $Res Function(WithdrawalRequestModel) _then;

  /// Create a copy of WithdrawalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reasonCode = null,
    Object? reasonDetail = freezed,
  }) {
    return _then(_self.copyWith(
      reasonCode: null == reasonCode
          ? _self.reasonCode
          : reasonCode // ignore: cast_nullable_to_non_nullable
              as String,
      reasonDetail: freezed == reasonDetail
          ? _self.reasonDetail
          : reasonDetail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [WithdrawalRequestModel].
extension WithdrawalRequestModelPatterns on WithdrawalRequestModel {
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
    TResult Function(_WithdrawalRequestModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WithdrawalRequestModel() when $default != null:
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
    TResult Function(_WithdrawalRequestModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WithdrawalRequestModel():
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
    TResult? Function(_WithdrawalRequestModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WithdrawalRequestModel() when $default != null:
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
    TResult Function(String reasonCode, String? reasonDetail)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WithdrawalRequestModel() when $default != null:
        return $default(_that.reasonCode, _that.reasonDetail);
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
    TResult Function(String reasonCode, String? reasonDetail) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WithdrawalRequestModel():
        return $default(_that.reasonCode, _that.reasonDetail);
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
    TResult? Function(String reasonCode, String? reasonDetail)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WithdrawalRequestModel() when $default != null:
        return $default(_that.reasonCode, _that.reasonDetail);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WithdrawalRequestModel implements WithdrawalRequestModel {
  const _WithdrawalRequestModel({required this.reasonCode, this.reasonDetail});
  factory _WithdrawalRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalRequestModelFromJson(json);

  @override
  final String reasonCode;
  @override
  final String? reasonDetail;

  /// Create a copy of WithdrawalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WithdrawalRequestModelCopyWith<_WithdrawalRequestModel> get copyWith =>
      __$WithdrawalRequestModelCopyWithImpl<_WithdrawalRequestModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WithdrawalRequestModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WithdrawalRequestModel &&
            (identical(other.reasonCode, reasonCode) ||
                other.reasonCode == reasonCode) &&
            (identical(other.reasonDetail, reasonDetail) ||
                other.reasonDetail == reasonDetail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reasonCode, reasonDetail);

  @override
  String toString() {
    return 'WithdrawalRequestModel(reasonCode: $reasonCode, reasonDetail: $reasonDetail)';
  }
}

/// @nodoc
abstract mixin class _$WithdrawalRequestModelCopyWith<$Res>
    implements $WithdrawalRequestModelCopyWith<$Res> {
  factory _$WithdrawalRequestModelCopyWith(_WithdrawalRequestModel value,
          $Res Function(_WithdrawalRequestModel) _then) =
      __$WithdrawalRequestModelCopyWithImpl;
  @override
  @useResult
  $Res call({String reasonCode, String? reasonDetail});
}

/// @nodoc
class __$WithdrawalRequestModelCopyWithImpl<$Res>
    implements _$WithdrawalRequestModelCopyWith<$Res> {
  __$WithdrawalRequestModelCopyWithImpl(this._self, this._then);

  final _WithdrawalRequestModel _self;
  final $Res Function(_WithdrawalRequestModel) _then;

  /// Create a copy of WithdrawalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? reasonCode = null,
    Object? reasonDetail = freezed,
  }) {
    return _then(_WithdrawalRequestModel(
      reasonCode: null == reasonCode
          ? _self.reasonCode
          : reasonCode // ignore: cast_nullable_to_non_nullable
              as String,
      reasonDetail: freezed == reasonDetail
          ? _self.reasonDetail
          : reasonDetail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
