// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_content_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateContentRequest {
  String get channel;
  String get purpose;
  String get tone;
  String get highlight;
  List<String> get keywords;
  bool get photoGuideEnabled;
  String? get forbidden;

  /// Create a copy of CreateContentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateContentRequestCopyWith<CreateContentRequest> get copyWith =>
      _$CreateContentRequestCopyWithImpl<CreateContentRequest>(
          this as CreateContentRequest, _$identity);

  /// Serializes this CreateContentRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateContentRequest &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.highlight, highlight) ||
                other.highlight == highlight) &&
            const DeepCollectionEquality().equals(other.keywords, keywords) &&
            (identical(other.photoGuideEnabled, photoGuideEnabled) ||
                other.photoGuideEnabled == photoGuideEnabled) &&
            (identical(other.forbidden, forbidden) ||
                other.forbidden == forbidden));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      channel,
      purpose,
      tone,
      highlight,
      const DeepCollectionEquality().hash(keywords),
      photoGuideEnabled,
      forbidden);

  @override
  String toString() {
    return 'CreateContentRequest(channel: $channel, purpose: $purpose, tone: $tone, highlight: $highlight, keywords: $keywords, photoGuideEnabled: $photoGuideEnabled, forbidden: $forbidden)';
  }
}

/// @nodoc
abstract mixin class $CreateContentRequestCopyWith<$Res> {
  factory $CreateContentRequestCopyWith(CreateContentRequest value,
          $Res Function(CreateContentRequest) _then) =
      _$CreateContentRequestCopyWithImpl;
  @useResult
  $Res call(
      {String channel,
      String purpose,
      String tone,
      String highlight,
      List<String> keywords,
      bool photoGuideEnabled,
      String? forbidden});
}

/// @nodoc
class _$CreateContentRequestCopyWithImpl<$Res>
    implements $CreateContentRequestCopyWith<$Res> {
  _$CreateContentRequestCopyWithImpl(this._self, this._then);

  final CreateContentRequest _self;
  final $Res Function(CreateContentRequest) _then;

  /// Create a copy of CreateContentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channel = null,
    Object? purpose = null,
    Object? tone = null,
    Object? highlight = null,
    Object? keywords = null,
    Object? photoGuideEnabled = null,
    Object? forbidden = freezed,
  }) {
    return _then(_self.copyWith(
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      purpose: null == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      tone: null == tone
          ? _self.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String,
      highlight: null == highlight
          ? _self.highlight
          : highlight // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: null == keywords
          ? _self.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photoGuideEnabled: null == photoGuideEnabled
          ? _self.photoGuideEnabled
          : photoGuideEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      forbidden: freezed == forbidden
          ? _self.forbidden
          : forbidden // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreateContentRequest].
extension CreateContentRequestPatterns on CreateContentRequest {
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
    TResult Function(_CreateContentRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateContentRequest() when $default != null:
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
    TResult Function(_CreateContentRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateContentRequest():
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
    TResult? Function(_CreateContentRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateContentRequest() when $default != null:
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
            String channel,
            String purpose,
            String tone,
            String highlight,
            List<String> keywords,
            bool photoGuideEnabled,
            String? forbidden)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateContentRequest() when $default != null:
        return $default(
            _that.channel,
            _that.purpose,
            _that.tone,
            _that.highlight,
            _that.keywords,
            _that.photoGuideEnabled,
            _that.forbidden);
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
            String channel,
            String purpose,
            String tone,
            String highlight,
            List<String> keywords,
            bool photoGuideEnabled,
            String? forbidden)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateContentRequest():
        return $default(
            _that.channel,
            _that.purpose,
            _that.tone,
            _that.highlight,
            _that.keywords,
            _that.photoGuideEnabled,
            _that.forbidden);
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
            String channel,
            String purpose,
            String tone,
            String highlight,
            List<String> keywords,
            bool photoGuideEnabled,
            String? forbidden)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateContentRequest() when $default != null:
        return $default(
            _that.channel,
            _that.purpose,
            _that.tone,
            _that.highlight,
            _that.keywords,
            _that.photoGuideEnabled,
            _that.forbidden);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CreateContentRequest implements CreateContentRequest {
  const _CreateContentRequest(
      {required this.channel,
      required this.purpose,
      required this.tone,
      required this.highlight,
      required final List<String> keywords,
      required this.photoGuideEnabled,
      this.forbidden})
      : _keywords = keywords;
  factory _CreateContentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateContentRequestFromJson(json);

  @override
  final String channel;
  @override
  final String purpose;
  @override
  final String tone;
  @override
  final String highlight;
  final List<String> _keywords;
  @override
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  final bool photoGuideEnabled;
  @override
  final String? forbidden;

  /// Create a copy of CreateContentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateContentRequestCopyWith<_CreateContentRequest> get copyWith =>
      __$CreateContentRequestCopyWithImpl<_CreateContentRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreateContentRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateContentRequest &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.highlight, highlight) ||
                other.highlight == highlight) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            (identical(other.photoGuideEnabled, photoGuideEnabled) ||
                other.photoGuideEnabled == photoGuideEnabled) &&
            (identical(other.forbidden, forbidden) ||
                other.forbidden == forbidden));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      channel,
      purpose,
      tone,
      highlight,
      const DeepCollectionEquality().hash(_keywords),
      photoGuideEnabled,
      forbidden);

  @override
  String toString() {
    return 'CreateContentRequest(channel: $channel, purpose: $purpose, tone: $tone, highlight: $highlight, keywords: $keywords, photoGuideEnabled: $photoGuideEnabled, forbidden: $forbidden)';
  }
}

/// @nodoc
abstract mixin class _$CreateContentRequestCopyWith<$Res>
    implements $CreateContentRequestCopyWith<$Res> {
  factory _$CreateContentRequestCopyWith(_CreateContentRequest value,
          $Res Function(_CreateContentRequest) _then) =
      __$CreateContentRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String channel,
      String purpose,
      String tone,
      String highlight,
      List<String> keywords,
      bool photoGuideEnabled,
      String? forbidden});
}

/// @nodoc
class __$CreateContentRequestCopyWithImpl<$Res>
    implements _$CreateContentRequestCopyWith<$Res> {
  __$CreateContentRequestCopyWithImpl(this._self, this._then);

  final _CreateContentRequest _self;
  final $Res Function(_CreateContentRequest) _then;

  /// Create a copy of CreateContentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? channel = null,
    Object? purpose = null,
    Object? tone = null,
    Object? highlight = null,
    Object? keywords = null,
    Object? photoGuideEnabled = null,
    Object? forbidden = freezed,
  }) {
    return _then(_CreateContentRequest(
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      purpose: null == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      tone: null == tone
          ? _self.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String,
      highlight: null == highlight
          ? _self.highlight
          : highlight // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: null == keywords
          ? _self._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photoGuideEnabled: null == photoGuideEnabled
          ? _self.photoGuideEnabled
          : photoGuideEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      forbidden: freezed == forbidden
          ? _self.forbidden
          : forbidden // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
