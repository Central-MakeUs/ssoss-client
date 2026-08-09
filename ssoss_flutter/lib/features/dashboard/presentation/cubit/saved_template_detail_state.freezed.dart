// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_template_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedTemplateDetailState {
  SavedTemplateDetail? get detail;
  bool get isLoading;
  String? get errorMessage;

  /// Create a copy of SavedTemplateDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SavedTemplateDetailStateCopyWith<SavedTemplateDetailState> get copyWith =>
      _$SavedTemplateDetailStateCopyWithImpl<SavedTemplateDetailState>(
          this as SavedTemplateDetailState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SavedTemplateDetailState &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, detail, isLoading, errorMessage);

  @override
  String toString() {
    return 'SavedTemplateDetailState(detail: $detail, isLoading: $isLoading, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $SavedTemplateDetailStateCopyWith<$Res> {
  factory $SavedTemplateDetailStateCopyWith(SavedTemplateDetailState value,
          $Res Function(SavedTemplateDetailState) _then) =
      _$SavedTemplateDetailStateCopyWithImpl;
  @useResult
  $Res call(
      {SavedTemplateDetail? detail, bool isLoading, String? errorMessage});
}

/// @nodoc
class _$SavedTemplateDetailStateCopyWithImpl<$Res>
    implements $SavedTemplateDetailStateCopyWith<$Res> {
  _$SavedTemplateDetailStateCopyWithImpl(this._self, this._then);

  final SavedTemplateDetailState _self;
  final $Res Function(SavedTemplateDetailState) _then;

  /// Create a copy of SavedTemplateDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? detail = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      detail: freezed == detail
          ? _self.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as SavedTemplateDetail?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SavedTemplateDetailState].
extension SavedTemplateDetailStatePatterns on SavedTemplateDetailState {
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
    TResult Function(_SavedTemplateDetailState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateDetailState() when $default != null:
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
    TResult Function(_SavedTemplateDetailState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateDetailState():
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
    TResult? Function(_SavedTemplateDetailState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateDetailState() when $default != null:
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
            SavedTemplateDetail? detail, bool isLoading, String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateDetailState() when $default != null:
        return $default(_that.detail, _that.isLoading, _that.errorMessage);
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
            SavedTemplateDetail? detail, bool isLoading, String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateDetailState():
        return $default(_that.detail, _that.isLoading, _that.errorMessage);
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
            SavedTemplateDetail? detail, bool isLoading, String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateDetailState() when $default != null:
        return $default(_that.detail, _that.isLoading, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SavedTemplateDetailState implements SavedTemplateDetailState {
  const _SavedTemplateDetailState(
      {this.detail, this.isLoading = true, this.errorMessage});

  @override
  final SavedTemplateDetail? detail;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  /// Create a copy of SavedTemplateDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedTemplateDetailStateCopyWith<_SavedTemplateDetailState> get copyWith =>
      __$SavedTemplateDetailStateCopyWithImpl<_SavedTemplateDetailState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SavedTemplateDetailState &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, detail, isLoading, errorMessage);

  @override
  String toString() {
    return 'SavedTemplateDetailState(detail: $detail, isLoading: $isLoading, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$SavedTemplateDetailStateCopyWith<$Res>
    implements $SavedTemplateDetailStateCopyWith<$Res> {
  factory _$SavedTemplateDetailStateCopyWith(_SavedTemplateDetailState value,
          $Res Function(_SavedTemplateDetailState) _then) =
      __$SavedTemplateDetailStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {SavedTemplateDetail? detail, bool isLoading, String? errorMessage});
}

/// @nodoc
class __$SavedTemplateDetailStateCopyWithImpl<$Res>
    implements _$SavedTemplateDetailStateCopyWith<$Res> {
  __$SavedTemplateDetailStateCopyWithImpl(this._self, this._then);

  final _SavedTemplateDetailState _self;
  final $Res Function(_SavedTemplateDetailState) _then;

  /// Create a copy of SavedTemplateDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? detail = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_SavedTemplateDetailState(
      detail: freezed == detail
          ? _self.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as SavedTemplateDetail?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
