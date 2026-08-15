// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentDetailState {
  ContentDetail? get detail;
  bool get isLoading;
  bool get didMutate;
  String? get errorMessage;

  /// Create a copy of ContentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentDetailStateCopyWith<ContentDetailState> get copyWith =>
      _$ContentDetailStateCopyWithImpl<ContentDetailState>(
          this as ContentDetailState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentDetailState &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.didMutate, didMutate) ||
                other.didMutate == didMutate) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, detail, isLoading, didMutate, errorMessage);

  @override
  String toString() {
    return 'ContentDetailState(detail: $detail, isLoading: $isLoading, didMutate: $didMutate, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ContentDetailStateCopyWith<$Res> {
  factory $ContentDetailStateCopyWith(
          ContentDetailState value, $Res Function(ContentDetailState) _then) =
      _$ContentDetailStateCopyWithImpl;
  @useResult
  $Res call(
      {ContentDetail? detail,
      bool isLoading,
      bool didMutate,
      String? errorMessage});
}

/// @nodoc
class _$ContentDetailStateCopyWithImpl<$Res>
    implements $ContentDetailStateCopyWith<$Res> {
  _$ContentDetailStateCopyWithImpl(this._self, this._then);

  final ContentDetailState _self;
  final $Res Function(ContentDetailState) _then;

  /// Create a copy of ContentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? detail = freezed,
    Object? isLoading = null,
    Object? didMutate = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      detail: freezed == detail
          ? _self.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as ContentDetail?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      didMutate: null == didMutate
          ? _self.didMutate
          : didMutate // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentDetailState].
extension ContentDetailStatePatterns on ContentDetailState {
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
    TResult Function(_ContentDetailState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentDetailState() when $default != null:
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
    TResult Function(_ContentDetailState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentDetailState():
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
    TResult? Function(_ContentDetailState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentDetailState() when $default != null:
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
    TResult Function(ContentDetail? detail, bool isLoading, bool didMutate,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentDetailState() when $default != null:
        return $default(
            _that.detail, _that.isLoading, _that.didMutate, _that.errorMessage);
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
    TResult Function(ContentDetail? detail, bool isLoading, bool didMutate,
            String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentDetailState():
        return $default(
            _that.detail, _that.isLoading, _that.didMutate, _that.errorMessage);
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
    TResult? Function(ContentDetail? detail, bool isLoading, bool didMutate,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentDetailState() when $default != null:
        return $default(
            _that.detail, _that.isLoading, _that.didMutate, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ContentDetailState implements ContentDetailState {
  const _ContentDetailState(
      {this.detail,
      this.isLoading = true,
      this.didMutate = false,
      this.errorMessage});

  @override
  final ContentDetail? detail;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool didMutate;
  @override
  final String? errorMessage;

  /// Create a copy of ContentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentDetailStateCopyWith<_ContentDetailState> get copyWith =>
      __$ContentDetailStateCopyWithImpl<_ContentDetailState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentDetailState &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.didMutate, didMutate) ||
                other.didMutate == didMutate) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, detail, isLoading, didMutate, errorMessage);

  @override
  String toString() {
    return 'ContentDetailState(detail: $detail, isLoading: $isLoading, didMutate: $didMutate, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$ContentDetailStateCopyWith<$Res>
    implements $ContentDetailStateCopyWith<$Res> {
  factory _$ContentDetailStateCopyWith(
          _ContentDetailState value, $Res Function(_ContentDetailState) _then) =
      __$ContentDetailStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ContentDetail? detail,
      bool isLoading,
      bool didMutate,
      String? errorMessage});
}

/// @nodoc
class __$ContentDetailStateCopyWithImpl<$Res>
    implements _$ContentDetailStateCopyWith<$Res> {
  __$ContentDetailStateCopyWithImpl(this._self, this._then);

  final _ContentDetailState _self;
  final $Res Function(_ContentDetailState) _then;

  /// Create a copy of ContentDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? detail = freezed,
    Object? isLoading = null,
    Object? didMutate = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_ContentDetailState(
      detail: freezed == detail
          ? _self.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as ContentDetail?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      didMutate: null == didMutate
          ? _self.didMutate
          : didMutate // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
