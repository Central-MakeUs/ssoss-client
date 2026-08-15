// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_save_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentSaveChannelModel {
  int get contentChannelId;
  String get channel;

  /// Create a copy of ContentSaveChannelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentSaveChannelModelCopyWith<ContentSaveChannelModel> get copyWith =>
      _$ContentSaveChannelModelCopyWithImpl<ContentSaveChannelModel>(
          this as ContentSaveChannelModel, _$identity);

  /// Serializes this ContentSaveChannelModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentSaveChannelModel &&
            (identical(other.contentChannelId, contentChannelId) ||
                other.contentChannelId == contentChannelId) &&
            (identical(other.channel, channel) || other.channel == channel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contentChannelId, channel);

  @override
  String toString() {
    return 'ContentSaveChannelModel(contentChannelId: $contentChannelId, channel: $channel)';
  }
}

/// @nodoc
abstract mixin class $ContentSaveChannelModelCopyWith<$Res> {
  factory $ContentSaveChannelModelCopyWith(ContentSaveChannelModel value,
          $Res Function(ContentSaveChannelModel) _then) =
      _$ContentSaveChannelModelCopyWithImpl;
  @useResult
  $Res call({int contentChannelId, String channel});
}

/// @nodoc
class _$ContentSaveChannelModelCopyWithImpl<$Res>
    implements $ContentSaveChannelModelCopyWith<$Res> {
  _$ContentSaveChannelModelCopyWithImpl(this._self, this._then);

  final ContentSaveChannelModel _self;
  final $Res Function(ContentSaveChannelModel) _then;

  /// Create a copy of ContentSaveChannelModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentChannelId = null,
    Object? channel = null,
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
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentSaveChannelModel].
extension ContentSaveChannelModelPatterns on ContentSaveChannelModel {
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
    TResult Function(_ContentSaveChannelModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentSaveChannelModel() when $default != null:
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
    TResult Function(_ContentSaveChannelModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentSaveChannelModel():
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
    TResult? Function(_ContentSaveChannelModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentSaveChannelModel() when $default != null:
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
    TResult Function(int contentChannelId, String channel)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentSaveChannelModel() when $default != null:
        return $default(_that.contentChannelId, _that.channel);
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
    TResult Function(int contentChannelId, String channel) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentSaveChannelModel():
        return $default(_that.contentChannelId, _that.channel);
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
    TResult? Function(int contentChannelId, String channel)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentSaveChannelModel() when $default != null:
        return $default(_that.contentChannelId, _that.channel);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ContentSaveChannelModel implements ContentSaveChannelModel {
  const _ContentSaveChannelModel(
      {required this.contentChannelId, required this.channel});
  factory _ContentSaveChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ContentSaveChannelModelFromJson(json);

  @override
  final int contentChannelId;
  @override
  final String channel;

  /// Create a copy of ContentSaveChannelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentSaveChannelModelCopyWith<_ContentSaveChannelModel> get copyWith =>
      __$ContentSaveChannelModelCopyWithImpl<_ContentSaveChannelModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContentSaveChannelModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentSaveChannelModel &&
            (identical(other.contentChannelId, contentChannelId) ||
                other.contentChannelId == contentChannelId) &&
            (identical(other.channel, channel) || other.channel == channel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contentChannelId, channel);

  @override
  String toString() {
    return 'ContentSaveChannelModel(contentChannelId: $contentChannelId, channel: $channel)';
  }
}

/// @nodoc
abstract mixin class _$ContentSaveChannelModelCopyWith<$Res>
    implements $ContentSaveChannelModelCopyWith<$Res> {
  factory _$ContentSaveChannelModelCopyWith(_ContentSaveChannelModel value,
          $Res Function(_ContentSaveChannelModel) _then) =
      __$ContentSaveChannelModelCopyWithImpl;
  @override
  @useResult
  $Res call({int contentChannelId, String channel});
}

/// @nodoc
class __$ContentSaveChannelModelCopyWithImpl<$Res>
    implements _$ContentSaveChannelModelCopyWith<$Res> {
  __$ContentSaveChannelModelCopyWithImpl(this._self, this._then);

  final _ContentSaveChannelModel _self;
  final $Res Function(_ContentSaveChannelModel) _then;

  /// Create a copy of ContentSaveChannelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? contentChannelId = null,
    Object? channel = null,
  }) {
    return _then(_ContentSaveChannelModel(
      contentChannelId: null == contentChannelId
          ? _self.contentChannelId
          : contentChannelId // ignore: cast_nullable_to_non_nullable
              as int,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ContentSaveResponseModel {
  int get contentId;
  List<ContentSaveChannelModel> get contents;

  /// Create a copy of ContentSaveResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentSaveResponseModelCopyWith<ContentSaveResponseModel> get copyWith =>
      _$ContentSaveResponseModelCopyWithImpl<ContentSaveResponseModel>(
          this as ContentSaveResponseModel, _$identity);

  /// Serializes this ContentSaveResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentSaveResponseModel &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            const DeepCollectionEquality().equals(other.contents, contents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, contentId, const DeepCollectionEquality().hash(contents));

  @override
  String toString() {
    return 'ContentSaveResponseModel(contentId: $contentId, contents: $contents)';
  }
}

/// @nodoc
abstract mixin class $ContentSaveResponseModelCopyWith<$Res> {
  factory $ContentSaveResponseModelCopyWith(ContentSaveResponseModel value,
          $Res Function(ContentSaveResponseModel) _then) =
      _$ContentSaveResponseModelCopyWithImpl;
  @useResult
  $Res call({int contentId, List<ContentSaveChannelModel> contents});
}

/// @nodoc
class _$ContentSaveResponseModelCopyWithImpl<$Res>
    implements $ContentSaveResponseModelCopyWith<$Res> {
  _$ContentSaveResponseModelCopyWithImpl(this._self, this._then);

  final ContentSaveResponseModel _self;
  final $Res Function(ContentSaveResponseModel) _then;

  /// Create a copy of ContentSaveResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentId = null,
    Object? contents = null,
  }) {
    return _then(_self.copyWith(
      contentId: null == contentId
          ? _self.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as int,
      contents: null == contents
          ? _self.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<ContentSaveChannelModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentSaveResponseModel].
extension ContentSaveResponseModelPatterns on ContentSaveResponseModel {
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
    TResult Function(_ContentSaveResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentSaveResponseModel() when $default != null:
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
    TResult Function(_ContentSaveResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentSaveResponseModel():
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
    TResult? Function(_ContentSaveResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentSaveResponseModel() when $default != null:
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
    TResult Function(int contentId, List<ContentSaveChannelModel> contents)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentSaveResponseModel() when $default != null:
        return $default(_that.contentId, _that.contents);
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
    TResult Function(int contentId, List<ContentSaveChannelModel> contents)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentSaveResponseModel():
        return $default(_that.contentId, _that.contents);
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
    TResult? Function(int contentId, List<ContentSaveChannelModel> contents)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentSaveResponseModel() when $default != null:
        return $default(_that.contentId, _that.contents);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ContentSaveResponseModel implements ContentSaveResponseModel {
  const _ContentSaveResponseModel(
      {required this.contentId,
      required final List<ContentSaveChannelModel> contents})
      : _contents = contents;
  factory _ContentSaveResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ContentSaveResponseModelFromJson(json);

  @override
  final int contentId;
  final List<ContentSaveChannelModel> _contents;
  @override
  List<ContentSaveChannelModel> get contents {
    if (_contents is EqualUnmodifiableListView) return _contents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contents);
  }

  /// Create a copy of ContentSaveResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentSaveResponseModelCopyWith<_ContentSaveResponseModel> get copyWith =>
      __$ContentSaveResponseModelCopyWithImpl<_ContentSaveResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContentSaveResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentSaveResponseModel &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            const DeepCollectionEquality().equals(other._contents, _contents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, contentId, const DeepCollectionEquality().hash(_contents));

  @override
  String toString() {
    return 'ContentSaveResponseModel(contentId: $contentId, contents: $contents)';
  }
}

/// @nodoc
abstract mixin class _$ContentSaveResponseModelCopyWith<$Res>
    implements $ContentSaveResponseModelCopyWith<$Res> {
  factory _$ContentSaveResponseModelCopyWith(_ContentSaveResponseModel value,
          $Res Function(_ContentSaveResponseModel) _then) =
      __$ContentSaveResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call({int contentId, List<ContentSaveChannelModel> contents});
}

/// @nodoc
class __$ContentSaveResponseModelCopyWithImpl<$Res>
    implements _$ContentSaveResponseModelCopyWith<$Res> {
  __$ContentSaveResponseModelCopyWithImpl(this._self, this._then);

  final _ContentSaveResponseModel _self;
  final $Res Function(_ContentSaveResponseModel) _then;

  /// Create a copy of ContentSaveResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? contentId = null,
    Object? contents = null,
  }) {
    return _then(_ContentSaveResponseModel(
      contentId: null == contentId
          ? _self.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as int,
      contents: null == contents
          ? _self._contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<ContentSaveChannelModel>,
    ));
  }
}

// dart format on
