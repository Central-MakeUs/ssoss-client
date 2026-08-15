// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generation_start_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenerationStartRequest {
  List<String> get channels;
  String get purpose;
  String get tone;
  String get emphasis;
  List<String> get keywords;
  bool get photoGuideChecked;
  String? get forbidden;
  int? get sourceContentId;

  /// Create a copy of GenerationStartRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenerationStartRequestCopyWith<GenerationStartRequest> get copyWith =>
      _$GenerationStartRequestCopyWithImpl<GenerationStartRequest>(
          this as GenerationStartRequest, _$identity);

  /// Serializes this GenerationStartRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenerationStartRequest &&
            const DeepCollectionEquality().equals(other.channels, channels) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.emphasis, emphasis) ||
                other.emphasis == emphasis) &&
            const DeepCollectionEquality().equals(other.keywords, keywords) &&
            (identical(other.photoGuideChecked, photoGuideChecked) ||
                other.photoGuideChecked == photoGuideChecked) &&
            (identical(other.forbidden, forbidden) ||
                other.forbidden == forbidden) &&
            (identical(other.sourceContentId, sourceContentId) ||
                other.sourceContentId == sourceContentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(channels),
      purpose,
      tone,
      emphasis,
      const DeepCollectionEquality().hash(keywords),
      photoGuideChecked,
      forbidden,
      sourceContentId);

  @override
  String toString() {
    return 'GenerationStartRequest(channels: $channels, purpose: $purpose, tone: $tone, emphasis: $emphasis, keywords: $keywords, photoGuideChecked: $photoGuideChecked, forbidden: $forbidden, sourceContentId: $sourceContentId)';
  }
}

/// @nodoc
abstract mixin class $GenerationStartRequestCopyWith<$Res> {
  factory $GenerationStartRequestCopyWith(GenerationStartRequest value,
          $Res Function(GenerationStartRequest) _then) =
      _$GenerationStartRequestCopyWithImpl;
  @useResult
  $Res call(
      {List<String> channels,
      String purpose,
      String tone,
      String emphasis,
      List<String> keywords,
      bool photoGuideChecked,
      String? forbidden,
      int? sourceContentId});
}

/// @nodoc
class _$GenerationStartRequestCopyWithImpl<$Res>
    implements $GenerationStartRequestCopyWith<$Res> {
  _$GenerationStartRequestCopyWithImpl(this._self, this._then);

  final GenerationStartRequest _self;
  final $Res Function(GenerationStartRequest) _then;

  /// Create a copy of GenerationStartRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channels = null,
    Object? purpose = null,
    Object? tone = null,
    Object? emphasis = null,
    Object? keywords = null,
    Object? photoGuideChecked = null,
    Object? forbidden = freezed,
    Object? sourceContentId = freezed,
  }) {
    return _then(_self.copyWith(
      channels: null == channels
          ? _self.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      purpose: null == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      tone: null == tone
          ? _self.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String,
      emphasis: null == emphasis
          ? _self.emphasis
          : emphasis // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: null == keywords
          ? _self.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photoGuideChecked: null == photoGuideChecked
          ? _self.photoGuideChecked
          : photoGuideChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      forbidden: freezed == forbidden
          ? _self.forbidden
          : forbidden // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceContentId: freezed == sourceContentId
          ? _self.sourceContentId
          : sourceContentId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [GenerationStartRequest].
extension GenerationStartRequestPatterns on GenerationStartRequest {
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
    TResult Function(_GenerationStartRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenerationStartRequest() when $default != null:
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
    TResult Function(_GenerationStartRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationStartRequest():
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
    TResult? Function(_GenerationStartRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationStartRequest() when $default != null:
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
            List<String> channels,
            String purpose,
            String tone,
            String emphasis,
            List<String> keywords,
            bool photoGuideChecked,
            String? forbidden,
            int? sourceContentId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenerationStartRequest() when $default != null:
        return $default(
            _that.channels,
            _that.purpose,
            _that.tone,
            _that.emphasis,
            _that.keywords,
            _that.photoGuideChecked,
            _that.forbidden,
            _that.sourceContentId);
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
            List<String> channels,
            String purpose,
            String tone,
            String emphasis,
            List<String> keywords,
            bool photoGuideChecked,
            String? forbidden,
            int? sourceContentId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationStartRequest():
        return $default(
            _that.channels,
            _that.purpose,
            _that.tone,
            _that.emphasis,
            _that.keywords,
            _that.photoGuideChecked,
            _that.forbidden,
            _that.sourceContentId);
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
            List<String> channels,
            String purpose,
            String tone,
            String emphasis,
            List<String> keywords,
            bool photoGuideChecked,
            String? forbidden,
            int? sourceContentId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationStartRequest() when $default != null:
        return $default(
            _that.channels,
            _that.purpose,
            _that.tone,
            _that.emphasis,
            _that.keywords,
            _that.photoGuideChecked,
            _that.forbidden,
            _that.sourceContentId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GenerationStartRequest implements GenerationStartRequest {
  const _GenerationStartRequest(
      {required final List<String> channels,
      required this.purpose,
      required this.tone,
      required this.emphasis,
      required final List<String> keywords,
      required this.photoGuideChecked,
      this.forbidden,
      this.sourceContentId})
      : _channels = channels,
        _keywords = keywords;
  factory _GenerationStartRequest.fromJson(Map<String, dynamic> json) =>
      _$GenerationStartRequestFromJson(json);

  final List<String> _channels;
  @override
  List<String> get channels {
    if (_channels is EqualUnmodifiableListView) return _channels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channels);
  }

  @override
  final String purpose;
  @override
  final String tone;
  @override
  final String emphasis;
  final List<String> _keywords;
  @override
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  final bool photoGuideChecked;
  @override
  final String? forbidden;
  @override
  final int? sourceContentId;

  /// Create a copy of GenerationStartRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenerationStartRequestCopyWith<_GenerationStartRequest> get copyWith =>
      __$GenerationStartRequestCopyWithImpl<_GenerationStartRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GenerationStartRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenerationStartRequest &&
            const DeepCollectionEquality().equals(other._channels, _channels) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.emphasis, emphasis) ||
                other.emphasis == emphasis) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            (identical(other.photoGuideChecked, photoGuideChecked) ||
                other.photoGuideChecked == photoGuideChecked) &&
            (identical(other.forbidden, forbidden) ||
                other.forbidden == forbidden) &&
            (identical(other.sourceContentId, sourceContentId) ||
                other.sourceContentId == sourceContentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_channels),
      purpose,
      tone,
      emphasis,
      const DeepCollectionEquality().hash(_keywords),
      photoGuideChecked,
      forbidden,
      sourceContentId);

  @override
  String toString() {
    return 'GenerationStartRequest(channels: $channels, purpose: $purpose, tone: $tone, emphasis: $emphasis, keywords: $keywords, photoGuideChecked: $photoGuideChecked, forbidden: $forbidden, sourceContentId: $sourceContentId)';
  }
}

/// @nodoc
abstract mixin class _$GenerationStartRequestCopyWith<$Res>
    implements $GenerationStartRequestCopyWith<$Res> {
  factory _$GenerationStartRequestCopyWith(_GenerationStartRequest value,
          $Res Function(_GenerationStartRequest) _then) =
      __$GenerationStartRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<String> channels,
      String purpose,
      String tone,
      String emphasis,
      List<String> keywords,
      bool photoGuideChecked,
      String? forbidden,
      int? sourceContentId});
}

/// @nodoc
class __$GenerationStartRequestCopyWithImpl<$Res>
    implements _$GenerationStartRequestCopyWith<$Res> {
  __$GenerationStartRequestCopyWithImpl(this._self, this._then);

  final _GenerationStartRequest _self;
  final $Res Function(_GenerationStartRequest) _then;

  /// Create a copy of GenerationStartRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? channels = null,
    Object? purpose = null,
    Object? tone = null,
    Object? emphasis = null,
    Object? keywords = null,
    Object? photoGuideChecked = null,
    Object? forbidden = freezed,
    Object? sourceContentId = freezed,
  }) {
    return _then(_GenerationStartRequest(
      channels: null == channels
          ? _self._channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      purpose: null == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      tone: null == tone
          ? _self.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String,
      emphasis: null == emphasis
          ? _self.emphasis
          : emphasis // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: null == keywords
          ? _self._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photoGuideChecked: null == photoGuideChecked
          ? _self.photoGuideChecked
          : photoGuideChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      forbidden: freezed == forbidden
          ? _self.forbidden
          : forbidden // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceContentId: freezed == sourceContentId
          ? _self.sourceContentId
          : sourceContentId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
