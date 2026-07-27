// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generation_channel_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenerationChannelResultModel {
  String get channel;
  String get body;
  String? get title;
  List<String> get hashtags;

  /// Create a copy of GenerationChannelResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenerationChannelResultModelCopyWith<GenerationChannelResultModel>
      get copyWith => _$GenerationChannelResultModelCopyWithImpl<
              GenerationChannelResultModel>(
          this as GenerationChannelResultModel, _$identity);

  /// Serializes this GenerationChannelResultModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenerationChannelResultModel &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other.hashtags, hashtags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, channel, body, title,
      const DeepCollectionEquality().hash(hashtags));

  @override
  String toString() {
    return 'GenerationChannelResultModel(channel: $channel, body: $body, title: $title, hashtags: $hashtags)';
  }
}

/// @nodoc
abstract mixin class $GenerationChannelResultModelCopyWith<$Res> {
  factory $GenerationChannelResultModelCopyWith(
          GenerationChannelResultModel value,
          $Res Function(GenerationChannelResultModel) _then) =
      _$GenerationChannelResultModelCopyWithImpl;
  @useResult
  $Res call(
      {String channel, String body, String? title, List<String> hashtags});
}

/// @nodoc
class _$GenerationChannelResultModelCopyWithImpl<$Res>
    implements $GenerationChannelResultModelCopyWith<$Res> {
  _$GenerationChannelResultModelCopyWithImpl(this._self, this._then);

  final GenerationChannelResultModel _self;
  final $Res Function(GenerationChannelResultModel) _then;

  /// Create a copy of GenerationChannelResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channel = null,
    Object? body = null,
    Object? title = freezed,
    Object? hashtags = null,
  }) {
    return _then(_self.copyWith(
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

/// Adds pattern-matching-related methods to [GenerationChannelResultModel].
extension GenerationChannelResultModelPatterns on GenerationChannelResultModel {
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
    TResult Function(_GenerationChannelResultModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenerationChannelResultModel() when $default != null:
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
    TResult Function(_GenerationChannelResultModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationChannelResultModel():
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
    TResult? Function(_GenerationChannelResultModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationChannelResultModel() when $default != null:
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
            String channel, String body, String? title, List<String> hashtags)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenerationChannelResultModel() when $default != null:
        return $default(_that.channel, _that.body, _that.title, _that.hashtags);
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
            String channel, String body, String? title, List<String> hashtags)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationChannelResultModel():
        return $default(_that.channel, _that.body, _that.title, _that.hashtags);
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
            String channel, String body, String? title, List<String> hashtags)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationChannelResultModel() when $default != null:
        return $default(_that.channel, _that.body, _that.title, _that.hashtags);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GenerationChannelResultModel implements GenerationChannelResultModel {
  const _GenerationChannelResultModel(
      {required this.channel,
      required this.body,
      this.title,
      final List<String> hashtags = const <String>[]})
      : _hashtags = hashtags;
  factory _GenerationChannelResultModel.fromJson(Map<String, dynamic> json) =>
      _$GenerationChannelResultModelFromJson(json);

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

  /// Create a copy of GenerationChannelResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenerationChannelResultModelCopyWith<_GenerationChannelResultModel>
      get copyWith => __$GenerationChannelResultModelCopyWithImpl<
          _GenerationChannelResultModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GenerationChannelResultModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenerationChannelResultModel &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, channel, body, title,
      const DeepCollectionEquality().hash(_hashtags));

  @override
  String toString() {
    return 'GenerationChannelResultModel(channel: $channel, body: $body, title: $title, hashtags: $hashtags)';
  }
}

/// @nodoc
abstract mixin class _$GenerationChannelResultModelCopyWith<$Res>
    implements $GenerationChannelResultModelCopyWith<$Res> {
  factory _$GenerationChannelResultModelCopyWith(
          _GenerationChannelResultModel value,
          $Res Function(_GenerationChannelResultModel) _then) =
      __$GenerationChannelResultModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String channel, String body, String? title, List<String> hashtags});
}

/// @nodoc
class __$GenerationChannelResultModelCopyWithImpl<$Res>
    implements _$GenerationChannelResultModelCopyWith<$Res> {
  __$GenerationChannelResultModelCopyWithImpl(this._self, this._then);

  final _GenerationChannelResultModel _self;
  final $Res Function(_GenerationChannelResultModel) _then;

  /// Create a copy of GenerationChannelResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? channel = null,
    Object? body = null,
    Object? title = freezed,
    Object? hashtags = null,
  }) {
    return _then(_GenerationChannelResultModel(
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
