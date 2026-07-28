// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentListItemModel {
  int get contentId;
  String get savedAt;
  List<String> get channels;
  String get purpose;
  String get tone;
  String get title;
  List<String> get hashtags;

  /// Create a copy of ContentListItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentListItemModelCopyWith<ContentListItemModel> get copyWith =>
      _$ContentListItemModelCopyWithImpl<ContentListItemModel>(
          this as ContentListItemModel, _$identity);

  /// Serializes this ContentListItemModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentListItemModel &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt) &&
            const DeepCollectionEquality().equals(other.channels, channels) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other.hashtags, hashtags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      contentId,
      savedAt,
      const DeepCollectionEquality().hash(channels),
      purpose,
      tone,
      title,
      const DeepCollectionEquality().hash(hashtags));

  @override
  String toString() {
    return 'ContentListItemModel(contentId: $contentId, savedAt: $savedAt, channels: $channels, purpose: $purpose, tone: $tone, title: $title, hashtags: $hashtags)';
  }
}

/// @nodoc
abstract mixin class $ContentListItemModelCopyWith<$Res> {
  factory $ContentListItemModelCopyWith(ContentListItemModel value,
          $Res Function(ContentListItemModel) _then) =
      _$ContentListItemModelCopyWithImpl;
  @useResult
  $Res call(
      {int contentId,
      String savedAt,
      List<String> channels,
      String purpose,
      String tone,
      String title,
      List<String> hashtags});
}

/// @nodoc
class _$ContentListItemModelCopyWithImpl<$Res>
    implements $ContentListItemModelCopyWith<$Res> {
  _$ContentListItemModelCopyWithImpl(this._self, this._then);

  final ContentListItemModel _self;
  final $Res Function(ContentListItemModel) _then;

  /// Create a copy of ContentListItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentId = null,
    Object? savedAt = null,
    Object? channels = null,
    Object? purpose = null,
    Object? tone = null,
    Object? title = null,
    Object? hashtags = null,
  }) {
    return _then(_self.copyWith(
      contentId: null == contentId
          ? _self.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as int,
      savedAt: null == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as String,
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
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      hashtags: null == hashtags
          ? _self.hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentListItemModel].
extension ContentListItemModelPatterns on ContentListItemModel {
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
    TResult Function(_ContentListItemModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentListItemModel() when $default != null:
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
    TResult Function(_ContentListItemModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentListItemModel():
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
    TResult? Function(_ContentListItemModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentListItemModel() when $default != null:
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
    TResult Function(int contentId, String savedAt, List<String> channels,
            String purpose, String tone, String title, List<String> hashtags)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentListItemModel() when $default != null:
        return $default(_that.contentId, _that.savedAt, _that.channels,
            _that.purpose, _that.tone, _that.title, _that.hashtags);
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
    TResult Function(int contentId, String savedAt, List<String> channels,
            String purpose, String tone, String title, List<String> hashtags)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentListItemModel():
        return $default(_that.contentId, _that.savedAt, _that.channels,
            _that.purpose, _that.tone, _that.title, _that.hashtags);
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
    TResult? Function(int contentId, String savedAt, List<String> channels,
            String purpose, String tone, String title, List<String> hashtags)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentListItemModel() when $default != null:
        return $default(_that.contentId, _that.savedAt, _that.channels,
            _that.purpose, _that.tone, _that.title, _that.hashtags);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ContentListItemModel implements ContentListItemModel {
  const _ContentListItemModel(
      {required this.contentId,
      required this.savedAt,
      required final List<String> channels,
      required this.purpose,
      required this.tone,
      required this.title,
      final List<String> hashtags = const <String>[]})
      : _channels = channels,
        _hashtags = hashtags;
  factory _ContentListItemModel.fromJson(Map<String, dynamic> json) =>
      _$ContentListItemModelFromJson(json);

  @override
  final int contentId;
  @override
  final String savedAt;
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
  final String title;
  final List<String> _hashtags;
  @override
  @JsonKey()
  List<String> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  /// Create a copy of ContentListItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentListItemModelCopyWith<_ContentListItemModel> get copyWith =>
      __$ContentListItemModelCopyWithImpl<_ContentListItemModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContentListItemModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentListItemModel &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt) &&
            const DeepCollectionEquality().equals(other._channels, _channels) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      contentId,
      savedAt,
      const DeepCollectionEquality().hash(_channels),
      purpose,
      tone,
      title,
      const DeepCollectionEquality().hash(_hashtags));

  @override
  String toString() {
    return 'ContentListItemModel(contentId: $contentId, savedAt: $savedAt, channels: $channels, purpose: $purpose, tone: $tone, title: $title, hashtags: $hashtags)';
  }
}

/// @nodoc
abstract mixin class _$ContentListItemModelCopyWith<$Res>
    implements $ContentListItemModelCopyWith<$Res> {
  factory _$ContentListItemModelCopyWith(_ContentListItemModel value,
          $Res Function(_ContentListItemModel) _then) =
      __$ContentListItemModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int contentId,
      String savedAt,
      List<String> channels,
      String purpose,
      String tone,
      String title,
      List<String> hashtags});
}

/// @nodoc
class __$ContentListItemModelCopyWithImpl<$Res>
    implements _$ContentListItemModelCopyWith<$Res> {
  __$ContentListItemModelCopyWithImpl(this._self, this._then);

  final _ContentListItemModel _self;
  final $Res Function(_ContentListItemModel) _then;

  /// Create a copy of ContentListItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? contentId = null,
    Object? savedAt = null,
    Object? channels = null,
    Object? purpose = null,
    Object? tone = null,
    Object? title = null,
    Object? hashtags = null,
  }) {
    return _then(_ContentListItemModel(
      contentId: null == contentId
          ? _self.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as int,
      savedAt: null == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as String,
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
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      hashtags: null == hashtags
          ? _self._hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$ContentListResponseModel {
  int get totalCount;
  int get page;
  int get size;
  bool get hasNext;
  List<ContentListItemModel> get contents;

  /// Create a copy of ContentListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentListResponseModelCopyWith<ContentListResponseModel> get copyWith =>
      _$ContentListResponseModelCopyWithImpl<ContentListResponseModel>(
          this as ContentListResponseModel, _$identity);

  /// Serializes this ContentListResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentListResponseModel &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            const DeepCollectionEquality().equals(other.contents, contents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount, page, size, hasNext,
      const DeepCollectionEquality().hash(contents));

  @override
  String toString() {
    return 'ContentListResponseModel(totalCount: $totalCount, page: $page, size: $size, hasNext: $hasNext, contents: $contents)';
  }
}

/// @nodoc
abstract mixin class $ContentListResponseModelCopyWith<$Res> {
  factory $ContentListResponseModelCopyWith(ContentListResponseModel value,
          $Res Function(ContentListResponseModel) _then) =
      _$ContentListResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {int totalCount,
      int page,
      int size,
      bool hasNext,
      List<ContentListItemModel> contents});
}

/// @nodoc
class _$ContentListResponseModelCopyWithImpl<$Res>
    implements $ContentListResponseModelCopyWith<$Res> {
  _$ContentListResponseModelCopyWithImpl(this._self, this._then);

  final ContentListResponseModel _self;
  final $Res Function(ContentListResponseModel) _then;

  /// Create a copy of ContentListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? page = null,
    Object? size = null,
    Object? hasNext = null,
    Object? contents = null,
  }) {
    return _then(_self.copyWith(
      totalCount: null == totalCount
          ? _self.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      contents: null == contents
          ? _self.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<ContentListItemModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentListResponseModel].
extension ContentListResponseModelPatterns on ContentListResponseModel {
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
    TResult Function(_ContentListResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentListResponseModel() when $default != null:
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
    TResult Function(_ContentListResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentListResponseModel():
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
    TResult? Function(_ContentListResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentListResponseModel() when $default != null:
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
    TResult Function(int totalCount, int page, int size, bool hasNext,
            List<ContentListItemModel> contents)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentListResponseModel() when $default != null:
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.contents);
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
    TResult Function(int totalCount, int page, int size, bool hasNext,
            List<ContentListItemModel> contents)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentListResponseModel():
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.contents);
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
    TResult? Function(int totalCount, int page, int size, bool hasNext,
            List<ContentListItemModel> contents)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentListResponseModel() when $default != null:
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.contents);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ContentListResponseModel implements ContentListResponseModel {
  const _ContentListResponseModel(
      {required this.totalCount,
      required this.page,
      required this.size,
      required this.hasNext,
      final List<ContentListItemModel> contents =
          const <ContentListItemModel>[]})
      : _contents = contents;
  factory _ContentListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ContentListResponseModelFromJson(json);

  @override
  final int totalCount;
  @override
  final int page;
  @override
  final int size;
  @override
  final bool hasNext;
  final List<ContentListItemModel> _contents;
  @override
  @JsonKey()
  List<ContentListItemModel> get contents {
    if (_contents is EqualUnmodifiableListView) return _contents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contents);
  }

  /// Create a copy of ContentListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentListResponseModelCopyWith<_ContentListResponseModel> get copyWith =>
      __$ContentListResponseModelCopyWithImpl<_ContentListResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContentListResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentListResponseModel &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            const DeepCollectionEquality().equals(other._contents, _contents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount, page, size, hasNext,
      const DeepCollectionEquality().hash(_contents));

  @override
  String toString() {
    return 'ContentListResponseModel(totalCount: $totalCount, page: $page, size: $size, hasNext: $hasNext, contents: $contents)';
  }
}

/// @nodoc
abstract mixin class _$ContentListResponseModelCopyWith<$Res>
    implements $ContentListResponseModelCopyWith<$Res> {
  factory _$ContentListResponseModelCopyWith(_ContentListResponseModel value,
          $Res Function(_ContentListResponseModel) _then) =
      __$ContentListResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int totalCount,
      int page,
      int size,
      bool hasNext,
      List<ContentListItemModel> contents});
}

/// @nodoc
class __$ContentListResponseModelCopyWithImpl<$Res>
    implements _$ContentListResponseModelCopyWith<$Res> {
  __$ContentListResponseModelCopyWithImpl(this._self, this._then);

  final _ContentListResponseModel _self;
  final $Res Function(_ContentListResponseModel) _then;

  /// Create a copy of ContentListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalCount = null,
    Object? page = null,
    Object? size = null,
    Object? hasNext = null,
    Object? contents = null,
  }) {
    return _then(_ContentListResponseModel(
      totalCount: null == totalCount
          ? _self.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      contents: null == contents
          ? _self._contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<ContentListItemModel>,
    ));
  }
}

// dart format on
