// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_balance_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreditBalanceResponseModel {
  int get balance;

  /// Create a copy of CreditBalanceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreditBalanceResponseModelCopyWith<CreditBalanceResponseModel>
      get copyWith =>
          _$CreditBalanceResponseModelCopyWithImpl<CreditBalanceResponseModel>(
              this as CreditBalanceResponseModel, _$identity);

  /// Serializes this CreditBalanceResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreditBalanceResponseModel &&
            (identical(other.balance, balance) || other.balance == balance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, balance);

  @override
  String toString() {
    return 'CreditBalanceResponseModel(balance: $balance)';
  }
}

/// @nodoc
abstract mixin class $CreditBalanceResponseModelCopyWith<$Res> {
  factory $CreditBalanceResponseModelCopyWith(CreditBalanceResponseModel value,
          $Res Function(CreditBalanceResponseModel) _then) =
      _$CreditBalanceResponseModelCopyWithImpl;
  @useResult
  $Res call({int balance});
}

/// @nodoc
class _$CreditBalanceResponseModelCopyWithImpl<$Res>
    implements $CreditBalanceResponseModelCopyWith<$Res> {
  _$CreditBalanceResponseModelCopyWithImpl(this._self, this._then);

  final CreditBalanceResponseModel _self;
  final $Res Function(CreditBalanceResponseModel) _then;

  /// Create a copy of CreditBalanceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
  }) {
    return _then(_self.copyWith(
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreditBalanceResponseModel].
extension CreditBalanceResponseModelPatterns on CreditBalanceResponseModel {
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
    TResult Function(_CreditBalanceResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreditBalanceResponseModel() when $default != null:
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
    TResult Function(_CreditBalanceResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditBalanceResponseModel():
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
    TResult? Function(_CreditBalanceResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditBalanceResponseModel() when $default != null:
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
    TResult Function(int balance)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreditBalanceResponseModel() when $default != null:
        return $default(_that.balance);
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
    TResult Function(int balance) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditBalanceResponseModel():
        return $default(_that.balance);
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
    TResult? Function(int balance)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditBalanceResponseModel() when $default != null:
        return $default(_that.balance);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CreditBalanceResponseModel implements CreditBalanceResponseModel {
  const _CreditBalanceResponseModel({required this.balance});
  factory _CreditBalanceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreditBalanceResponseModelFromJson(json);

  @override
  final int balance;

  /// Create a copy of CreditBalanceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreditBalanceResponseModelCopyWith<_CreditBalanceResponseModel>
      get copyWith => __$CreditBalanceResponseModelCopyWithImpl<
          _CreditBalanceResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreditBalanceResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreditBalanceResponseModel &&
            (identical(other.balance, balance) || other.balance == balance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, balance);

  @override
  String toString() {
    return 'CreditBalanceResponseModel(balance: $balance)';
  }
}

/// @nodoc
abstract mixin class _$CreditBalanceResponseModelCopyWith<$Res>
    implements $CreditBalanceResponseModelCopyWith<$Res> {
  factory _$CreditBalanceResponseModelCopyWith(
          _CreditBalanceResponseModel value,
          $Res Function(_CreditBalanceResponseModel) _then) =
      __$CreditBalanceResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call({int balance});
}

/// @nodoc
class __$CreditBalanceResponseModelCopyWithImpl<$Res>
    implements _$CreditBalanceResponseModelCopyWith<$Res> {
  __$CreditBalanceResponseModelCopyWithImpl(this._self, this._then);

  final _CreditBalanceResponseModel _self;
  final $Res Function(_CreditBalanceResponseModel) _then;

  /// Create a copy of CreditBalanceResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? balance = null,
  }) {
    return _then(_CreditBalanceResponseModel(
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
