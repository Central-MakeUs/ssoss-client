// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_balance_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreditBalanceState {
  bool get isLoading;
  int? get balance;
  String? get errorMessage;

  /// Create a copy of CreditBalanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreditBalanceStateCopyWith<CreditBalanceState> get copyWith =>
      _$CreditBalanceStateCopyWithImpl<CreditBalanceState>(
          this as CreditBalanceState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreditBalanceState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, balance, errorMessage);

  @override
  String toString() {
    return 'CreditBalanceState(isLoading: $isLoading, balance: $balance, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $CreditBalanceStateCopyWith<$Res> {
  factory $CreditBalanceStateCopyWith(
          CreditBalanceState value, $Res Function(CreditBalanceState) _then) =
      _$CreditBalanceStateCopyWithImpl;
  @useResult
  $Res call({bool isLoading, int? balance, String? errorMessage});
}

/// @nodoc
class _$CreditBalanceStateCopyWithImpl<$Res>
    implements $CreditBalanceStateCopyWith<$Res> {
  _$CreditBalanceStateCopyWithImpl(this._self, this._then);

  final CreditBalanceState _self;
  final $Res Function(CreditBalanceState) _then;

  /// Create a copy of CreditBalanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? balance = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      balance: freezed == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreditBalanceState].
extension CreditBalanceStatePatterns on CreditBalanceState {
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
    TResult Function(_CreditBalanceState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreditBalanceState() when $default != null:
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
    TResult Function(_CreditBalanceState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditBalanceState():
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
    TResult? Function(_CreditBalanceState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditBalanceState() when $default != null:
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
    TResult Function(bool isLoading, int? balance, String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreditBalanceState() when $default != null:
        return $default(_that.isLoading, _that.balance, _that.errorMessage);
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
    TResult Function(bool isLoading, int? balance, String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditBalanceState():
        return $default(_that.isLoading, _that.balance, _that.errorMessage);
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
    TResult? Function(bool isLoading, int? balance, String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditBalanceState() when $default != null:
        return $default(_that.isLoading, _that.balance, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CreditBalanceState implements CreditBalanceState {
  const _CreditBalanceState(
      {this.isLoading = false, this.balance, this.errorMessage});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final int? balance;
  @override
  final String? errorMessage;

  /// Create a copy of CreditBalanceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreditBalanceStateCopyWith<_CreditBalanceState> get copyWith =>
      __$CreditBalanceStateCopyWithImpl<_CreditBalanceState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreditBalanceState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, balance, errorMessage);

  @override
  String toString() {
    return 'CreditBalanceState(isLoading: $isLoading, balance: $balance, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$CreditBalanceStateCopyWith<$Res>
    implements $CreditBalanceStateCopyWith<$Res> {
  factory _$CreditBalanceStateCopyWith(
          _CreditBalanceState value, $Res Function(_CreditBalanceState) _then) =
      __$CreditBalanceStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool isLoading, int? balance, String? errorMessage});
}

/// @nodoc
class __$CreditBalanceStateCopyWithImpl<$Res>
    implements _$CreditBalanceStateCopyWith<$Res> {
  __$CreditBalanceStateCopyWithImpl(this._self, this._then);

  final _CreditBalanceState _self;
  final $Res Function(_CreditBalanceState) _then;

  /// Create a copy of CreditBalanceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? balance = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_CreditBalanceState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      balance: freezed == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
