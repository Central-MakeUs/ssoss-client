// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_detail_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentDetailResponseModel {
  int get contentId;
  String get purpose;
  String get tone;
  List<String> get keywords;
  List<ContentChannelResponseModel> get contents;

  /// Create a copy of ContentDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentDetailResponseModelCopyWith<ContentDetailResponseModel>
      get copyWith =>
          _$ContentDetailResponseModelCopyWithImpl<ContentDetailResponseModel>(
              this as ContentDetailResponseModel, _$identity);

  /// Serializes this ContentDetailResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentDetailResponseModel &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            const DeepCollectionEquality().equals(other.keywords, keywords) &&
            const DeepCollectionEquality().equals(other.contents, contents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      contentId,
      purpose,
      tone,
      const DeepCollectionEquality().hash(keywords),
      const DeepCollectionEquality().hash(contents));

  @override
  String toString() {
    return 'ContentDetailResponseModel(contentId: $contentId, purpose: $purpose, tone: $tone, keywords: $keywords, contents: $contents)';
  }
}

/// @nodoc
abstract mixin class $ContentDetailResponseModelCopyWith<$Res> {
  factory $ContentDetailResponseModelCopyWith(ContentDetailResponseModel value,
          $Res Function(ContentDetailResponseModel) _then) =
      _$ContentDetailResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {int contentId,
      String purpose,
      String tone,
      List<String> keywords,
      List<ContentChannelResponseModel> contents});
}

/// @nodoc
class _$ContentDetailResponseModelCopyWithImpl<$Res>
    implements $ContentDetailResponseModelCopyWith<$Res> {
  _$ContentDetailResponseModelCopyWithImpl(this._self, this._then);

  final ContentDetailResponseModel _self;
  final $Res Function(ContentDetailResponseModel) _then;

  /// Create a copy of ContentDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentId = null,
    Object? purpose = null,
    Object? tone = null,
    Object? keywords = null,
    Object? contents = null,
  }) {
    return _then(_self.copyWith(
      contentId: null == contentId
          ? _self.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as int,
      purpose: null == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      tone: null == tone
          ? _self.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: null == keywords
          ? _self.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      contents: null == contents
          ? _self.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<ContentChannelResponseModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentDetailResponseModel].
extension ContentDetailResponseModelPatterns on ContentDetailResponseModel {
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
    TResult Function(_ContentDetailResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentDetailResponseModel() when $default != null:
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
    TResult Function(_ContentDetailResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentDetailResponseModel():
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
    TResult? Function(_ContentDetailResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentDetailResponseModel() when $default != null:
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
    TResult Function(int contentId, String purpose, String tone,
            List<String> keywords, List<ContentChannelResponseModel> contents)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentDetailResponseModel() when $default != null:
        return $default(_that.contentId, _that.purpose, _that.tone,
            _that.keywords, _that.contents);
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
    TResult Function(int contentId, String purpose, String tone,
            List<String> keywords, List<ContentChannelResponseModel> contents)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentDetailResponseModel():
        return $default(_that.contentId, _that.purpose, _that.tone,
            _that.keywords, _that.contents);
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
    TResult? Function(int contentId, String purpose, String tone,
            List<String> keywords, List<ContentChannelResponseModel> contents)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentDetailResponseModel() when $default != null:
        return $default(_that.contentId, _that.purpose, _that.tone,
            _that.keywords, _that.contents);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ContentDetailResponseModel implements ContentDetailResponseModel {
  const _ContentDetailResponseModel(
      {required this.contentId,
      required this.purpose,
      required this.tone,
      final List<String> keywords = const <String>[],
      final List<ContentChannelResponseModel> contents =
          const <ContentChannelResponseModel>[]})
      : _keywords = keywords,
        _contents = contents;
  factory _ContentDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailResponseModelFromJson(json);

  @override
  final int contentId;
  @override
  final String purpose;
  @override
  final String tone;
  final List<String> _keywords;
  @override
  @JsonKey()
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  final List<ContentChannelResponseModel> _contents;
  @override
  @JsonKey()
  List<ContentChannelResponseModel> get contents {
    if (_contents is EqualUnmodifiableListView) return _contents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contents);
  }

  /// Create a copy of ContentDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentDetailResponseModelCopyWith<_ContentDetailResponseModel>
      get copyWith => __$ContentDetailResponseModelCopyWithImpl<
          _ContentDetailResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContentDetailResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentDetailResponseModel &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            const DeepCollectionEquality().equals(other._contents, _contents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      contentId,
      purpose,
      tone,
      const DeepCollectionEquality().hash(_keywords),
      const DeepCollectionEquality().hash(_contents));

  @override
  String toString() {
    return 'ContentDetailResponseModel(contentId: $contentId, purpose: $purpose, tone: $tone, keywords: $keywords, contents: $contents)';
  }
}

/// @nodoc
abstract mixin class _$ContentDetailResponseModelCopyWith<$Res>
    implements $ContentDetailResponseModelCopyWith<$Res> {
  factory _$ContentDetailResponseModelCopyWith(
          _ContentDetailResponseModel value,
          $Res Function(_ContentDetailResponseModel) _then) =
      __$ContentDetailResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int contentId,
      String purpose,
      String tone,
      List<String> keywords,
      List<ContentChannelResponseModel> contents});
}

/// @nodoc
class __$ContentDetailResponseModelCopyWithImpl<$Res>
    implements _$ContentDetailResponseModelCopyWith<$Res> {
  __$ContentDetailResponseModelCopyWithImpl(this._self, this._then);

  final _ContentDetailResponseModel _self;
  final $Res Function(_ContentDetailResponseModel) _then;

  /// Create a copy of ContentDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? contentId = null,
    Object? purpose = null,
    Object? tone = null,
    Object? keywords = null,
    Object? contents = null,
  }) {
    return _then(_ContentDetailResponseModel(
      contentId: null == contentId
          ? _self.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as int,
      purpose: null == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      tone: null == tone
          ? _self.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: null == keywords
          ? _self._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      contents: null == contents
          ? _self._contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<ContentChannelResponseModel>,
    ));
  }
}

// dart format on
