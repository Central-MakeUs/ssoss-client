// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_channel_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentChannelResponseModel {
  int get contentChannelId;
  String get channel;
  String get body;
  String? get title;
  List<String> get hashtags;

  /// Create a copy of ContentChannelResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentChannelResponseModelCopyWith<ContentChannelResponseModel>
      get copyWith => _$ContentChannelResponseModelCopyWithImpl<
              ContentChannelResponseModel>(
          this as ContentChannelResponseModel, _$identity);

  /// Serializes this ContentChannelResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentChannelResponseModel &&
            (identical(other.contentChannelId, contentChannelId) ||
                other.contentChannelId == contentChannelId) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other.hashtags, hashtags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contentChannelId, channel, body,
      title, const DeepCollectionEquality().hash(hashtags));

  @override
  String toString() {
    return 'ContentChannelResponseModel(contentChannelId: $contentChannelId, channel: $channel, body: $body, title: $title, hashtags: $hashtags)';
  }
}

/// @nodoc
abstract mixin class $ContentChannelResponseModelCopyWith<$Res> {
  factory $ContentChannelResponseModelCopyWith(
          ContentChannelResponseModel value,
          $Res Function(ContentChannelResponseModel) _then) =
      _$ContentChannelResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {int contentChannelId,
      String channel,
      String body,
      String? title,
      List<String> hashtags});
}

/// @nodoc
class _$ContentChannelResponseModelCopyWithImpl<$Res>
    implements $ContentChannelResponseModelCopyWith<$Res> {
  _$ContentChannelResponseModelCopyWithImpl(this._self, this._then);

  final ContentChannelResponseModel _self;
  final $Res Function(ContentChannelResponseModel) _then;

  /// Create a copy of ContentChannelResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentChannelId = null,
    Object? channel = null,
    Object? body = null,
    Object? title = freezed,
    Object? hashtags = null,
  }) {
    return _then(_self.copyWith(
      contentChannelId: null == contentChannelId
          ? _self.contentChannelId
          : contentChannelId // ignore: cast_nullable_to_non_nullable
              as int,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      hashtags: null == hashtags
          ? _self.hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentChannelResponseModel].
extension ContentChannelResponseModelPatterns on ContentChannelResponseModel {
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
    TResult Function(_ContentChannelResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentChannelResponseModel() when $default != null:
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
    TResult Function(_ContentChannelResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentChannelResponseModel():
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
    TResult? Function(_ContentChannelResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentChannelResponseModel() when $default != null:
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
    TResult Function(int contentChannelId, String channel, String body,
            String? title, List<String> hashtags)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentChannelResponseModel() when $default != null:
        return $default(_that.contentChannelId, _that.channel, _that.body,
            _that.title, _that.hashtags);
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
    TResult Function(int contentChannelId, String channel, String body,
            String? title, List<String> hashtags)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentChannelResponseModel():
        return $default(_that.contentChannelId, _that.channel, _that.body,
            _that.title, _that.hashtags);
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
    TResult? Function(int contentChannelId, String channel, String body,
            String? title, List<String> hashtags)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentChannelResponseModel() when $default != null:
        return $default(_that.contentChannelId, _that.channel, _that.body,
            _that.title, _that.hashtags);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ContentChannelResponseModel implements ContentChannelResponseModel {
  const _ContentChannelResponseModel(
      {required this.contentChannelId,
      required this.channel,
      required this.body,
      this.title,
      final List<String> hashtags = const <String>[]})
      : _hashtags = hashtags;
  factory _ContentChannelResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ContentChannelResponseModelFromJson(json);

  @override
  final int contentChannelId;
  @override
  final String channel;
  @override
  final String body;
  @override
  final String? title;
  final List<String> _hashtags;
  @override
  @JsonKey()
  List<String> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  /// Create a copy of ContentChannelResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentChannelResponseModelCopyWith<_ContentChannelResponseModel>
      get copyWith => __$ContentChannelResponseModelCopyWithImpl<
          _ContentChannelResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContentChannelResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentChannelResponseModel &&
            (identical(other.contentChannelId, contentChannelId) ||
                other.contentChannelId == contentChannelId) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contentChannelId, channel, body,
      title, const DeepCollectionEquality().hash(_hashtags));

  @override
  String toString() {
    return 'ContentChannelResponseModel(contentChannelId: $contentChannelId, channel: $channel, body: $body, title: $title, hashtags: $hashtags)';
  }
}

/// @nodoc
abstract mixin class _$ContentChannelResponseModelCopyWith<$Res>
    implements $ContentChannelResponseModelCopyWith<$Res> {
  factory _$ContentChannelResponseModelCopyWith(
          _ContentChannelResponseModel value,
          $Res Function(_ContentChannelResponseModel) _then) =
      __$ContentChannelResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int contentChannelId,
      String channel,
      String body,
      String? title,
      List<String> hashtags});
}

/// @nodoc
class __$ContentChannelResponseModelCopyWithImpl<$Res>
    implements _$ContentChannelResponseModelCopyWith<$Res> {
  __$ContentChannelResponseModelCopyWithImpl(this._self, this._then);

  final _ContentChannelResponseModel _self;
  final $Res Function(_ContentChannelResponseModel) _then;

  /// Create a copy of ContentChannelResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? contentChannelId = null,
    Object? channel = null,
    Object? body = null,
    Object? title = freezed,
    Object? hashtags = null,
  }) {
    return _then(_ContentChannelResponseModel(
      contentChannelId: null == contentChannelId
          ? _self.contentChannelId
          : contentChannelId // ignore: cast_nullable_to_non_nullable
              as int,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      hashtags: null == hashtags
          ? _self._hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
