// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_create_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentCreateState {
  ContentCreateStep get step;
  List<UploadChannel> get channels;
  UploadPurpose? get purpose;
  ContentTone? get tone;
  String get highlight;
  String get forbidden;
  List<String> get keywords;
  bool get photoGuideEnabled;
  String? get errorMessage;

  /// Create a copy of ContentCreateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentCreateStateCopyWith<ContentCreateState> get copyWith =>
      _$ContentCreateStateCopyWithImpl<ContentCreateState>(
          this as ContentCreateState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentCreateState &&
            (identical(other.step, step) || other.step == step) &&
            const DeepCollectionEquality().equals(other.channels, channels) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.highlight, highlight) ||
                other.highlight == highlight) &&
            (identical(other.forbidden, forbidden) ||
                other.forbidden == forbidden) &&
            const DeepCollectionEquality().equals(other.keywords, keywords) &&
            (identical(other.photoGuideEnabled, photoGuideEnabled) ||
                other.photoGuideEnabled == photoGuideEnabled) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      step,
      const DeepCollectionEquality().hash(channels),
      purpose,
      tone,
      highlight,
      forbidden,
      const DeepCollectionEquality().hash(keywords),
      photoGuideEnabled,
      errorMessage);

  @override
  String toString() {
    return 'ContentCreateState(step: $step, channels: $channels, purpose: $purpose, tone: $tone, highlight: $highlight, forbidden: $forbidden, keywords: $keywords, photoGuideEnabled: $photoGuideEnabled, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ContentCreateStateCopyWith<$Res> {
  factory $ContentCreateStateCopyWith(
          ContentCreateState value, $Res Function(ContentCreateState) _then) =
      _$ContentCreateStateCopyWithImpl;
  @useResult
  $Res call(
      {ContentCreateStep step,
      List<UploadChannel> channels,
      UploadPurpose? purpose,
      ContentTone? tone,
      String highlight,
      String forbidden,
      List<String> keywords,
      bool photoGuideEnabled,
      String? errorMessage});
}

/// @nodoc
class _$ContentCreateStateCopyWithImpl<$Res>
    implements $ContentCreateStateCopyWith<$Res> {
  _$ContentCreateStateCopyWithImpl(this._self, this._then);

  final ContentCreateState _self;
  final $Res Function(ContentCreateState) _then;

  /// Create a copy of ContentCreateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? channels = null,
    Object? purpose = freezed,
    Object? tone = freezed,
    Object? highlight = null,
    Object? forbidden = null,
    Object? keywords = null,
    Object? photoGuideEnabled = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      step: null == step
          ? _self.step
          : step // ignore: cast_nullable_to_non_nullable
              as ContentCreateStep,
      channels: null == channels
          ? _self.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<UploadChannel>,
      purpose: freezed == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as UploadPurpose?,
      tone: freezed == tone
          ? _self.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as ContentTone?,
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
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentCreateState].
extension ContentCreateStatePatterns on ContentCreateState {
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
    TResult Function(_ContentCreateState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentCreateState() when $default != null:
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
    TResult Function(_ContentCreateState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentCreateState():
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
    TResult? Function(_ContentCreateState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentCreateState() when $default != null:
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
            ContentCreateStep step,
            List<UploadChannel> channels,
            UploadPurpose? purpose,
            ContentTone? tone,
            String highlight,
            String forbidden,
            List<String> keywords,
            bool photoGuideEnabled,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentCreateState() when $default != null:
        return $default(
            _that.step,
            _that.channels,
            _that.purpose,
            _that.tone,
            _that.highlight,
            _that.forbidden,
            _that.keywords,
            _that.photoGuideEnabled,
            _that.errorMessage);
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
            ContentCreateStep step,
            List<UploadChannel> channels,
            UploadPurpose? purpose,
            ContentTone? tone,
            String highlight,
            String forbidden,
            List<String> keywords,
            bool photoGuideEnabled,
            String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentCreateState():
        return $default(
            _that.step,
            _that.channels,
            _that.purpose,
            _that.tone,
            _that.highlight,
            _that.forbidden,
            _that.keywords,
            _that.photoGuideEnabled,
            _that.errorMessage);
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
            ContentCreateStep step,
            List<UploadChannel> channels,
            UploadPurpose? purpose,
            ContentTone? tone,
            String highlight,
            String forbidden,
            List<String> keywords,
            bool photoGuideEnabled,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentCreateState() when $default != null:
        return $default(
            _that.step,
            _that.channels,
            _that.purpose,
            _that.tone,
            _that.highlight,
            _that.forbidden,
            _that.keywords,
            _that.photoGuideEnabled,
            _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ContentCreateState extends ContentCreateState {
  const _ContentCreateState(
      {this.step = ContentCreateStep.channel,
      final List<UploadChannel> channels = const <UploadChannel>[],
      this.purpose,
      this.tone,
      this.highlight = '',
      this.forbidden = '',
      final List<String> keywords = const <String>[],
      this.photoGuideEnabled = false,
      this.errorMessage})
      : _channels = channels,
        _keywords = keywords,
        super._();

  @override
  @JsonKey()
  final ContentCreateStep step;
  final List<UploadChannel> _channels;
  @override
  @JsonKey()
  List<UploadChannel> get channels {
    if (_channels is EqualUnmodifiableListView) return _channels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channels);
  }

  @override
  final UploadPurpose? purpose;
  @override
  final ContentTone? tone;
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
  @override
  final String? errorMessage;

  /// Create a copy of ContentCreateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentCreateStateCopyWith<_ContentCreateState> get copyWith =>
      __$ContentCreateStateCopyWithImpl<_ContentCreateState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentCreateState &&
            (identical(other.step, step) || other.step == step) &&
            const DeepCollectionEquality().equals(other._channels, _channels) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.highlight, highlight) ||
                other.highlight == highlight) &&
            (identical(other.forbidden, forbidden) ||
                other.forbidden == forbidden) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            (identical(other.photoGuideEnabled, photoGuideEnabled) ||
                other.photoGuideEnabled == photoGuideEnabled) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      step,
      const DeepCollectionEquality().hash(_channels),
      purpose,
      tone,
      highlight,
      forbidden,
      const DeepCollectionEquality().hash(_keywords),
      photoGuideEnabled,
      errorMessage);

  @override
  String toString() {
    return 'ContentCreateState(step: $step, channels: $channels, purpose: $purpose, tone: $tone, highlight: $highlight, forbidden: $forbidden, keywords: $keywords, photoGuideEnabled: $photoGuideEnabled, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$ContentCreateStateCopyWith<$Res>
    implements $ContentCreateStateCopyWith<$Res> {
  factory _$ContentCreateStateCopyWith(
          _ContentCreateState value, $Res Function(_ContentCreateState) _then) =
      __$ContentCreateStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ContentCreateStep step,
      List<UploadChannel> channels,
      UploadPurpose? purpose,
      ContentTone? tone,
      String highlight,
      String forbidden,
      List<String> keywords,
      bool photoGuideEnabled,
      String? errorMessage});
}

/// @nodoc
class __$ContentCreateStateCopyWithImpl<$Res>
    implements _$ContentCreateStateCopyWith<$Res> {
  __$ContentCreateStateCopyWithImpl(this._self, this._then);

  final _ContentCreateState _self;
  final $Res Function(_ContentCreateState) _then;

  /// Create a copy of ContentCreateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? step = null,
    Object? channels = null,
    Object? purpose = freezed,
    Object? tone = freezed,
    Object? highlight = null,
    Object? forbidden = null,
    Object? keywords = null,
    Object? photoGuideEnabled = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_ContentCreateState(
      step: null == step
          ? _self.step
          : step // ignore: cast_nullable_to_non_nullable
              as ContentCreateStep,
      channels: null == channels
          ? _self._channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<UploadChannel>,
      purpose: freezed == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as UploadPurpose?,
      tone: freezed == tone
          ? _self.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as ContentTone?,
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
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
