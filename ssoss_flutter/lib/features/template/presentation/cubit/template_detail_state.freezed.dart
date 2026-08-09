// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TemplateDetailState {
  RecommendedTemplateDetail? get detail;
  bool get isLoading;
  bool get isApplying;
  bool get isTogglingBookmark;
  String? get errorMessage;

  /// Create a copy of TemplateDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TemplateDetailStateCopyWith<TemplateDetailState> get copyWith =>
      _$TemplateDetailStateCopyWithImpl<TemplateDetailState>(
          this as TemplateDetailState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TemplateDetailState &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isApplying, isApplying) ||
                other.isApplying == isApplying) &&
            (identical(other.isTogglingBookmark, isTogglingBookmark) ||
                other.isTogglingBookmark == isTogglingBookmark) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, detail, isLoading, isApplying,
      isTogglingBookmark, errorMessage);

  @override
  String toString() {
    return 'TemplateDetailState(detail: $detail, isLoading: $isLoading, isApplying: $isApplying, isTogglingBookmark: $isTogglingBookmark, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $TemplateDetailStateCopyWith<$Res> {
  factory $TemplateDetailStateCopyWith(
          TemplateDetailState value, $Res Function(TemplateDetailState) _then) =
      _$TemplateDetailStateCopyWithImpl;
  @useResult
  $Res call(
      {RecommendedTemplateDetail? detail,
      bool isLoading,
      bool isApplying,
      bool isTogglingBookmark,
      String? errorMessage});
}

/// @nodoc
class _$TemplateDetailStateCopyWithImpl<$Res>
    implements $TemplateDetailStateCopyWith<$Res> {
  _$TemplateDetailStateCopyWithImpl(this._self, this._then);

  final TemplateDetailState _self;
  final $Res Function(TemplateDetailState) _then;

  /// Create a copy of TemplateDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? detail = freezed,
    Object? isLoading = null,
    Object? isApplying = null,
    Object? isTogglingBookmark = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      detail: freezed == detail
          ? _self.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as RecommendedTemplateDetail?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isApplying: null == isApplying
          ? _self.isApplying
          : isApplying // ignore: cast_nullable_to_non_nullable
              as bool,
      isTogglingBookmark: null == isTogglingBookmark
          ? _self.isTogglingBookmark
          : isTogglingBookmark // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [TemplateDetailState].
extension TemplateDetailStatePatterns on TemplateDetailState {
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
    TResult Function(_TemplateDetailState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TemplateDetailState() when $default != null:
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
    TResult Function(_TemplateDetailState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateDetailState():
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
    TResult? Function(_TemplateDetailState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateDetailState() when $default != null:
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
    TResult Function(RecommendedTemplateDetail? detail, bool isLoading,
            bool isApplying, bool isTogglingBookmark, String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TemplateDetailState() when $default != null:
        return $default(_that.detail, _that.isLoading, _that.isApplying,
            _that.isTogglingBookmark, _that.errorMessage);
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
    TResult Function(RecommendedTemplateDetail? detail, bool isLoading,
            bool isApplying, bool isTogglingBookmark, String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateDetailState():
        return $default(_that.detail, _that.isLoading, _that.isApplying,
            _that.isTogglingBookmark, _that.errorMessage);
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
    TResult? Function(RecommendedTemplateDetail? detail, bool isLoading,
            bool isApplying, bool isTogglingBookmark, String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateDetailState() when $default != null:
        return $default(_that.detail, _that.isLoading, _that.isApplying,
            _that.isTogglingBookmark, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TemplateDetailState implements TemplateDetailState {
  const _TemplateDetailState(
      {this.detail,
      this.isLoading = true,
      this.isApplying = false,
      this.isTogglingBookmark = false,
      this.errorMessage});

  @override
  final RecommendedTemplateDetail? detail;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isApplying;
  @override
  @JsonKey()
  final bool isTogglingBookmark;
  @override
  final String? errorMessage;

  /// Create a copy of TemplateDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TemplateDetailStateCopyWith<_TemplateDetailState> get copyWith =>
      __$TemplateDetailStateCopyWithImpl<_TemplateDetailState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TemplateDetailState &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isApplying, isApplying) ||
                other.isApplying == isApplying) &&
            (identical(other.isTogglingBookmark, isTogglingBookmark) ||
                other.isTogglingBookmark == isTogglingBookmark) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, detail, isLoading, isApplying,
      isTogglingBookmark, errorMessage);

  @override
  String toString() {
    return 'TemplateDetailState(detail: $detail, isLoading: $isLoading, isApplying: $isApplying, isTogglingBookmark: $isTogglingBookmark, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$TemplateDetailStateCopyWith<$Res>
    implements $TemplateDetailStateCopyWith<$Res> {
  factory _$TemplateDetailStateCopyWith(_TemplateDetailState value,
          $Res Function(_TemplateDetailState) _then) =
      __$TemplateDetailStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {RecommendedTemplateDetail? detail,
      bool isLoading,
      bool isApplying,
      bool isTogglingBookmark,
      String? errorMessage});
}

/// @nodoc
class __$TemplateDetailStateCopyWithImpl<$Res>
    implements _$TemplateDetailStateCopyWith<$Res> {
  __$TemplateDetailStateCopyWithImpl(this._self, this._then);

  final _TemplateDetailState _self;
  final $Res Function(_TemplateDetailState) _then;

  /// Create a copy of TemplateDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? detail = freezed,
    Object? isLoading = null,
    Object? isApplying = null,
    Object? isTogglingBookmark = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_TemplateDetailState(
      detail: freezed == detail
          ? _self.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as RecommendedTemplateDetail?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isApplying: null == isApplying
          ? _self.isApplying
          : isApplying // ignore: cast_nullable_to_non_nullable
              as bool,
      isTogglingBookmark: null == isTogglingBookmark
          ? _self.isTogglingBookmark
          : isTogglingBookmark // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
