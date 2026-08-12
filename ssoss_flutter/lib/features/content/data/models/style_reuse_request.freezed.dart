// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'style_reuse_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StyleReuseRequest {
  String get emphasis;
  List<String> get keywords;
  bool get photoGuideChecked;
  String? get forbidden;

  /// Create a copy of StyleReuseRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StyleReuseRequestCopyWith<StyleReuseRequest> get copyWith =>
      _$StyleReuseRequestCopyWithImpl<StyleReuseRequest>(
          this as StyleReuseRequest, _$identity);

  /// Serializes this StyleReuseRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StyleReuseRequest &&
            (identical(other.emphasis, emphasis) ||
                other.emphasis == emphasis) &&
            const DeepCollectionEquality().equals(other.keywords, keywords) &&
            (identical(other.photoGuideChecked, photoGuideChecked) ||
                other.photoGuideChecked == photoGuideChecked) &&
            (identical(other.forbidden, forbidden) ||
                other.forbidden == forbidden));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      emphasis,
      const DeepCollectionEquality().hash(keywords),
      photoGuideChecked,
      forbidden);

  @override
  String toString() {
    return 'StyleReuseRequest(emphasis: $emphasis, keywords: $keywords, photoGuideChecked: $photoGuideChecked, forbidden: $forbidden)';
  }
}

/// @nodoc
abstract mixin class $StyleReuseRequestCopyWith<$Res> {
  factory $StyleReuseRequestCopyWith(
          StyleReuseRequest value, $Res Function(StyleReuseRequest) _then) =
      _$StyleReuseRequestCopyWithImpl;
  @useResult
  $Res call(
      {String emphasis,
      List<String> keywords,
      bool photoGuideChecked,
      String? forbidden});
}

/// @nodoc
class _$StyleReuseRequestCopyWithImpl<$Res>
    implements $StyleReuseRequestCopyWith<$Res> {
  _$StyleReuseRequestCopyWithImpl(this._self, this._then);

  final StyleReuseRequest _self;
  final $Res Function(StyleReuseRequest) _then;

  /// Create a copy of StyleReuseRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emphasis = null,
    Object? keywords = null,
    Object? photoGuideChecked = null,
    Object? forbidden = freezed,
  }) {
    return _then(_self.copyWith(
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
    ));
  }
}

/// Adds pattern-matching-related methods to [StyleReuseRequest].
extension StyleReuseRequestPatterns on StyleReuseRequest {
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
    TResult Function(_StyleReuseRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StyleReuseRequest() when $default != null:
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
    TResult Function(_StyleReuseRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StyleReuseRequest():
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
    TResult? Function(_StyleReuseRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StyleReuseRequest() when $default != null:
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
    TResult Function(String emphasis, List<String> keywords,
            bool photoGuideChecked, String? forbidden)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StyleReuseRequest() when $default != null:
        return $default(_that.emphasis, _that.keywords, _that.photoGuideChecked,
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
    TResult Function(String emphasis, List<String> keywords,
            bool photoGuideChecked, String? forbidden)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StyleReuseRequest():
        return $default(_that.emphasis, _that.keywords, _that.photoGuideChecked,
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
    TResult? Function(String emphasis, List<String> keywords,
            bool photoGuideChecked, String? forbidden)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StyleReuseRequest() when $default != null:
        return $default(_that.emphasis, _that.keywords, _that.photoGuideChecked,
            _that.forbidden);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StyleReuseRequest implements StyleReuseRequest {
  const _StyleReuseRequest(
      {required this.emphasis,
      required final List<String> keywords,
      required this.photoGuideChecked,
      this.forbidden})
      : _keywords = keywords;
  factory _StyleReuseRequest.fromJson(Map<String, dynamic> json) =>
      _$StyleReuseRequestFromJson(json);

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

  /// Create a copy of StyleReuseRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StyleReuseRequestCopyWith<_StyleReuseRequest> get copyWith =>
      __$StyleReuseRequestCopyWithImpl<_StyleReuseRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StyleReuseRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StyleReuseRequest &&
            (identical(other.emphasis, emphasis) ||
                other.emphasis == emphasis) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            (identical(other.photoGuideChecked, photoGuideChecked) ||
                other.photoGuideChecked == photoGuideChecked) &&
            (identical(other.forbidden, forbidden) ||
                other.forbidden == forbidden));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      emphasis,
      const DeepCollectionEquality().hash(_keywords),
      photoGuideChecked,
      forbidden);

  @override
  String toString() {
    return 'StyleReuseRequest(emphasis: $emphasis, keywords: $keywords, photoGuideChecked: $photoGuideChecked, forbidden: $forbidden)';
  }
}

/// @nodoc
abstract mixin class _$StyleReuseRequestCopyWith<$Res>
    implements $StyleReuseRequestCopyWith<$Res> {
  factory _$StyleReuseRequestCopyWith(
          _StyleReuseRequest value, $Res Function(_StyleReuseRequest) _then) =
      __$StyleReuseRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String emphasis,
      List<String> keywords,
      bool photoGuideChecked,
      String? forbidden});
}

/// @nodoc
class __$StyleReuseRequestCopyWithImpl<$Res>
    implements _$StyleReuseRequestCopyWith<$Res> {
  __$StyleReuseRequestCopyWithImpl(this._self, this._then);

  final _StyleReuseRequest _self;
  final $Res Function(_StyleReuseRequest) _then;

  /// Create a copy of StyleReuseRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? emphasis = null,
    Object? keywords = null,
    Object? photoGuideChecked = null,
    Object? forbidden = freezed,
  }) {
    return _then(_StyleReuseRequest(
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
    ));
  }
}

// dart format on
