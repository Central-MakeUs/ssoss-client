// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hashtag_bundle_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HashtagBundleModel {
  int get id;
  String get name;
  List<String> get hashtags;
  bool get bookmarked;

  /// Create a copy of HashtagBundleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HashtagBundleModelCopyWith<HashtagBundleModel> get copyWith =>
      _$HashtagBundleModelCopyWithImpl<HashtagBundleModel>(
          this as HashtagBundleModel, _$identity);

  /// Serializes this HashtagBundleModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HashtagBundleModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.hashtags, hashtags) &&
            (identical(other.bookmarked, bookmarked) ||
                other.bookmarked == bookmarked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name,
      const DeepCollectionEquality().hash(hashtags), bookmarked);

  @override
  String toString() {
    return 'HashtagBundleModel(id: $id, name: $name, hashtags: $hashtags, bookmarked: $bookmarked)';
  }
}

/// @nodoc
abstract mixin class $HashtagBundleModelCopyWith<$Res> {
  factory $HashtagBundleModelCopyWith(
          HashtagBundleModel value, $Res Function(HashtagBundleModel) _then) =
      _$HashtagBundleModelCopyWithImpl;
  @useResult
  $Res call({int id, String name, List<String> hashtags, bool bookmarked});
}

/// @nodoc
class _$HashtagBundleModelCopyWithImpl<$Res>
    implements $HashtagBundleModelCopyWith<$Res> {
  _$HashtagBundleModelCopyWithImpl(this._self, this._then);

  final HashtagBundleModel _self;
  final $Res Function(HashtagBundleModel) _then;

  /// Create a copy of HashtagBundleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? hashtags = null,
    Object? bookmarked = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      hashtags: null == hashtags
          ? _self.hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bookmarked: null == bookmarked
          ? _self.bookmarked
          : bookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [HashtagBundleModel].
extension HashtagBundleModelPatterns on HashtagBundleModel {
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
    TResult Function(_HashtagBundleModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HashtagBundleModel() when $default != null:
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
    TResult Function(_HashtagBundleModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HashtagBundleModel():
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
    TResult? Function(_HashtagBundleModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HashtagBundleModel() when $default != null:
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
            int id, String name, List<String> hashtags, bool bookmarked)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HashtagBundleModel() when $default != null:
        return $default(_that.id, _that.name, _that.hashtags, _that.bookmarked);
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
            int id, String name, List<String> hashtags, bool bookmarked)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HashtagBundleModel():
        return $default(_that.id, _that.name, _that.hashtags, _that.bookmarked);
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
            int id, String name, List<String> hashtags, bool bookmarked)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HashtagBundleModel() when $default != null:
        return $default(_that.id, _that.name, _that.hashtags, _that.bookmarked);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HashtagBundleModel implements HashtagBundleModel {
  const _HashtagBundleModel(
      {required this.id,
      required this.name,
      final List<String> hashtags = const <String>[],
      this.bookmarked = false})
      : _hashtags = hashtags;
  factory _HashtagBundleModel.fromJson(Map<String, dynamic> json) =>
      _$HashtagBundleModelFromJson(json);

  @override
  final int id;
  @override
  final String name;
  final List<String> _hashtags;
  @override
  @JsonKey()
  List<String> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  @override
  @JsonKey()
  final bool bookmarked;

  /// Create a copy of HashtagBundleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HashtagBundleModelCopyWith<_HashtagBundleModel> get copyWith =>
      __$HashtagBundleModelCopyWithImpl<_HashtagBundleModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HashtagBundleModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HashtagBundleModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags) &&
            (identical(other.bookmarked, bookmarked) ||
                other.bookmarked == bookmarked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name,
      const DeepCollectionEquality().hash(_hashtags), bookmarked);

  @override
  String toString() {
    return 'HashtagBundleModel(id: $id, name: $name, hashtags: $hashtags, bookmarked: $bookmarked)';
  }
}

/// @nodoc
abstract mixin class _$HashtagBundleModelCopyWith<$Res>
    implements $HashtagBundleModelCopyWith<$Res> {
  factory _$HashtagBundleModelCopyWith(
          _HashtagBundleModel value, $Res Function(_HashtagBundleModel) _then) =
      __$HashtagBundleModelCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String name, List<String> hashtags, bool bookmarked});
}

/// @nodoc
class __$HashtagBundleModelCopyWithImpl<$Res>
    implements _$HashtagBundleModelCopyWith<$Res> {
  __$HashtagBundleModelCopyWithImpl(this._self, this._then);

  final _HashtagBundleModel _self;
  final $Res Function(_HashtagBundleModel) _then;

  /// Create a copy of HashtagBundleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? hashtags = null,
    Object? bookmarked = null,
  }) {
    return _then(_HashtagBundleModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      hashtags: null == hashtags
          ? _self._hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bookmarked: null == bookmarked
          ? _self.bookmarked
          : bookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$HashtagBundleListResponseModel {
  int get totalCount;
  int get page;
  int get size;
  bool get hasNext;
  List<HashtagBundleModel> get bundles;

  /// Create a copy of HashtagBundleListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HashtagBundleListResponseModelCopyWith<HashtagBundleListResponseModel>
      get copyWith => _$HashtagBundleListResponseModelCopyWithImpl<
              HashtagBundleListResponseModel>(
          this as HashtagBundleListResponseModel, _$identity);

  /// Serializes this HashtagBundleListResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HashtagBundleListResponseModel &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            const DeepCollectionEquality().equals(other.bundles, bundles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount, page, size, hasNext,
      const DeepCollectionEquality().hash(bundles));

  @override
  String toString() {
    return 'HashtagBundleListResponseModel(totalCount: $totalCount, page: $page, size: $size, hasNext: $hasNext, bundles: $bundles)';
  }
}

/// @nodoc
abstract mixin class $HashtagBundleListResponseModelCopyWith<$Res> {
  factory $HashtagBundleListResponseModelCopyWith(
          HashtagBundleListResponseModel value,
          $Res Function(HashtagBundleListResponseModel) _then) =
      _$HashtagBundleListResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {int totalCount,
      int page,
      int size,
      bool hasNext,
      List<HashtagBundleModel> bundles});
}

/// @nodoc
class _$HashtagBundleListResponseModelCopyWithImpl<$Res>
    implements $HashtagBundleListResponseModelCopyWith<$Res> {
  _$HashtagBundleListResponseModelCopyWithImpl(this._self, this._then);

  final HashtagBundleListResponseModel _self;
  final $Res Function(HashtagBundleListResponseModel) _then;

  /// Create a copy of HashtagBundleListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? page = null,
    Object? size = null,
    Object? hasNext = null,
    Object? bundles = null,
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
      bundles: null == bundles
          ? _self.bundles
          : bundles // ignore: cast_nullable_to_non_nullable
              as List<HashtagBundleModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [HashtagBundleListResponseModel].
extension HashtagBundleListResponseModelPatterns
    on HashtagBundleListResponseModel {
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
    TResult Function(_HashtagBundleListResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HashtagBundleListResponseModel() when $default != null:
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
    TResult Function(_HashtagBundleListResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HashtagBundleListResponseModel():
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
    TResult? Function(_HashtagBundleListResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HashtagBundleListResponseModel() when $default != null:
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
            List<HashtagBundleModel> bundles)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HashtagBundleListResponseModel() when $default != null:
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.bundles);
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
            List<HashtagBundleModel> bundles)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HashtagBundleListResponseModel():
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.bundles);
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
            List<HashtagBundleModel> bundles)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HashtagBundleListResponseModel() when $default != null:
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.bundles);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HashtagBundleListResponseModel
    implements HashtagBundleListResponseModel {
  const _HashtagBundleListResponseModel(
      {required this.totalCount,
      required this.page,
      required this.size,
      required this.hasNext,
      final List<HashtagBundleModel> bundles = const <HashtagBundleModel>[]})
      : _bundles = bundles;
  factory _HashtagBundleListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HashtagBundleListResponseModelFromJson(json);

  @override
  final int totalCount;
  @override
  final int page;
  @override
  final int size;
  @override
  final bool hasNext;
  final List<HashtagBundleModel> _bundles;
  @override
  @JsonKey()
  List<HashtagBundleModel> get bundles {
    if (_bundles is EqualUnmodifiableListView) return _bundles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bundles);
  }

  /// Create a copy of HashtagBundleListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HashtagBundleListResponseModelCopyWith<_HashtagBundleListResponseModel>
      get copyWith => __$HashtagBundleListResponseModelCopyWithImpl<
          _HashtagBundleListResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HashtagBundleListResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HashtagBundleListResponseModel &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            const DeepCollectionEquality().equals(other._bundles, _bundles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount, page, size, hasNext,
      const DeepCollectionEquality().hash(_bundles));

  @override
  String toString() {
    return 'HashtagBundleListResponseModel(totalCount: $totalCount, page: $page, size: $size, hasNext: $hasNext, bundles: $bundles)';
  }
}

/// @nodoc
abstract mixin class _$HashtagBundleListResponseModelCopyWith<$Res>
    implements $HashtagBundleListResponseModelCopyWith<$Res> {
  factory _$HashtagBundleListResponseModelCopyWith(
          _HashtagBundleListResponseModel value,
          $Res Function(_HashtagBundleListResponseModel) _then) =
      __$HashtagBundleListResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int totalCount,
      int page,
      int size,
      bool hasNext,
      List<HashtagBundleModel> bundles});
}

/// @nodoc
class __$HashtagBundleListResponseModelCopyWithImpl<$Res>
    implements _$HashtagBundleListResponseModelCopyWith<$Res> {
  __$HashtagBundleListResponseModelCopyWithImpl(this._self, this._then);

  final _HashtagBundleListResponseModel _self;
  final $Res Function(_HashtagBundleListResponseModel) _then;

  /// Create a copy of HashtagBundleListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalCount = null,
    Object? page = null,
    Object? size = null,
    Object? hasNext = null,
    Object? bundles = null,
  }) {
    return _then(_HashtagBundleListResponseModel(
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
      bundles: null == bundles
          ? _self._bundles
          : bundles // ignore: cast_nullable_to_non_nullable
              as List<HashtagBundleModel>,
    ));
  }
}

// dart format on
