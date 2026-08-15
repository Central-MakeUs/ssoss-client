// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_style_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewStyleDetailState {
  String get highlight;
  String get forbidden;
  List<String> get keywords;
  bool get photoGuideEnabled;

  /// Create a copy of NewStyleDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NewStyleDetailStateCopyWith<NewStyleDetailState> get copyWith =>
      _$NewStyleDetailStateCopyWithImpl<NewStyleDetailState>(
          this as NewStyleDetailState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NewStyleDetailState &&
            (identical(other.highlight, highlight) ||
                other.highlight == highlight) &&
            (identical(other.forbidden, forbidden) ||
                other.forbidden == forbidden) &&
            const DeepCollectionEquality().equals(other.keywords, keywords) &&
            (identical(other.photoGuideEnabled, photoGuideEnabled) ||
                other.photoGuideEnabled == photoGuideEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, highlight, forbidden,
      const DeepCollectionEquality().hash(keywords), photoGuideEnabled);

  @override
  String toString() {
    return 'NewStyleDetailState(highlight: $highlight, forbidden: $forbidden, keywords: $keywords, photoGuideEnabled: $photoGuideEnabled)';
  }
}

/// @nodoc
abstract mixin class $NewStyleDetailStateCopyWith<$Res> {
  factory $NewStyleDetailStateCopyWith(
          NewStyleDetailState value, $Res Function(NewStyleDetailState) _then) =
      _$NewStyleDetailStateCopyWithImpl;
  @useResult
  $Res call(
      {String highlight,
      String forbidden,
      List<String> keywords,
      bool photoGuideEnabled});
}

/// @nodoc
class _$NewStyleDetailStateCopyWithImpl<$Res>
    implements $NewStyleDetailStateCopyWith<$Res> {
  _$NewStyleDetailStateCopyWithImpl(this._self, this._then);

  final NewStyleDetailState _self;
  final $Res Function(NewStyleDetailState) _then;

  /// Create a copy of NewStyleDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? highlight = null,
    Object? forbidden = null,
    Object? keywords = null,
    Object? photoGuideEnabled = null,
  }) {
    return _then(_self.copyWith(
      highlight: null == highlight
          ? _self.highlight
          : highlight // ignore: cast_nullable_to_non_nullable
              as String,
      forbidden: null == forbidden
          ? _self.forbidden
          : forbidden // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: null == keywords
          ? _self.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photoGuideEnabled: null == photoGuideEnabled
          ? _self.photoGuideEnabled
          : photoGuideEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [NewStyleDetailState].
extension NewStyleDetailStatePatterns on NewStyleDetailState {
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
    TResult Function(_NewStyleDetailState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NewStyleDetailState() when $default != null:
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
    TResult Function(_NewStyleDetailState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NewStyleDetailState():
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
    TResult? Function(_NewStyleDetailState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NewStyleDetailState() when $default != null:
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
    TResult Function(String highlight, String forbidden, List<String> keywords,
            bool photoGuideEnabled)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NewStyleDetailState() when $default != null:
        return $default(_that.highlight, _that.forbidden, _that.keywords,
            _that.photoGuideEnabled);
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
    TResult Function(String highlight, String forbidden, List<String> keywords,
            bool photoGuideEnabled)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NewStyleDetailState():
        return $default(_that.highlight, _that.forbidden, _that.keywords,
            _that.photoGuideEnabled);
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
    TResult? Function(String highlight, String forbidden, List<String> keywords,
            bool photoGuideEnabled)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NewStyleDetailState() when $default != null:
        return $default(_that.highlight, _that.forbidden, _that.keywords,
            _that.photoGuideEnabled);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NewStyleDetailState extends NewStyleDetailState {
  const _NewStyleDetailState(
      {this.highlight = '',
      this.forbidden = '',
      final List<String> keywords = const <String>[],
      this.photoGuideEnabled = true})
      : _keywords = keywords,
        super._();

  @override
  @JsonKey()
  final String highlight;
  @override
  @JsonKey()
  final String forbidden;
  final List<String> _keywords;
  @override
  @JsonKey()
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  @JsonKey()
  final bool photoGuideEnabled;

  /// Create a copy of NewStyleDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NewStyleDetailStateCopyWith<_NewStyleDetailState> get copyWith =>
      __$NewStyleDetailStateCopyWithImpl<_NewStyleDetailState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NewStyleDetailState &&
            (identical(other.highlight, highlight) ||
                other.highlight == highlight) &&
            (identical(other.forbidden, forbidden) ||
                other.forbidden == forbidden) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            (identical(other.photoGuideEnabled, photoGuideEnabled) ||
                other.photoGuideEnabled == photoGuideEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, highlight, forbidden,
      const DeepCollectionEquality().hash(_keywords), photoGuideEnabled);

  @override
  String toString() {
    return 'NewStyleDetailState(highlight: $highlight, forbidden: $forbidden, keywords: $keywords, photoGuideEnabled: $photoGuideEnabled)';
  }
}

/// @nodoc
abstract mixin class _$NewStyleDetailStateCopyWith<$Res>
    implements $NewStyleDetailStateCopyWith<$Res> {
  factory _$NewStyleDetailStateCopyWith(_NewStyleDetailState value,
          $Res Function(_NewStyleDetailState) _then) =
      __$NewStyleDetailStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String highlight,
      String forbidden,
      List<String> keywords,
      bool photoGuideEnabled});
}

/// @nodoc
class __$NewStyleDetailStateCopyWithImpl<$Res>
    implements _$NewStyleDetailStateCopyWith<$Res> {
  __$NewStyleDetailStateCopyWithImpl(this._self, this._then);

  final _NewStyleDetailState _self;
  final $Res Function(_NewStyleDetailState) _then;

  /// Create a copy of NewStyleDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? highlight = null,
    Object? forbidden = null,
    Object? keywords = null,
    Object? photoGuideEnabled = null,
  }) {
    return _then(_NewStyleDetailState(
      highlight: null == highlight
          ? _self.highlight
          : highlight // ignore: cast_nullable_to_non_nullable
              as String,
      forbidden: null == forbidden
          ? _self.forbidden
          : forbidden // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: null == keywords
          ? _self._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photoGuideEnabled: null == photoGuideEnabled
          ? _self.photoGuideEnabled
          : photoGuideEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
